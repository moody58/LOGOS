# Isolated durable context loader. Production roots and automatic partial recovery are excluded.
Set-StrictMode -Version 2.0
$script:AIOSrecoveryModulePath = $PSCommandPath

function Read-AIOSDurableInputs {
    param([string]$HandoffPath, [string]$PolicyPath, [string]$ProfilePath, [string]$EntryPath, [string]$ExpectedHandoffHash)
    $h = Read-AIOSCanonicalJson $HandoffPath
    if ((Get-AIOSHash ([IO.File]::ReadAllBytes($HandoffPath))) -cne $ExpectedHandoffHash) { throw 'STOP: handoff hash mismatch.' }
    $p = Read-AIOSCanonicalJson $PolicyPath
    $profile = Read-AIOSCanonicalJson $ProfilePath
    $schemaPath = Join-Path ([IO.Path]::GetDirectoryName($EntryPath)) 'DOC-HANDOFF.schema.json'
    $schema = Read-AIOSCanonicalJson $schemaPath
    [AIOSHandoff.StrictJson]::Validate($h, $schema)
    Assert-AIOSFields $p @('format', 'stage', 'project', 'repository', 'root', 'branch', 'origin_urls', 'allowed_paths', 'allowed_new_directories', 'expected_status', 'instruction_files')
    Assert-AIOSFields $profile @('id', 'project', 'repository', 'source_commit', 'naming', 'archiving', 'versioning', 'sources')
    Assert-AIOSProfilePolicy $p $profile
    if ($p.format -cne 'AIOS-DOCUMENT-POLICY/1.0' -or @('isolated-test', 'pilot-check-only', 'isolated-document-test', 'document-ranges') -cnotcontains $p.stage) { throw 'STOP: unsupported policy stage.' }
    if ($h.project -cne $p.project -or $h.project -cne $profile.project -or $h.repository.origin -cne $p.repository -or $h.repository.origin -cne $profile.repository) { throw 'STOP: project/repository profile mismatch.' }
    if ($h.repository.root -cne $p.root -or $h.repository.branch -cne $p.branch) { throw 'STOP: root/branch policy mismatch.' }
    if ($h.source_snapshot.repository -cne $p.repository -or $h.source_snapshot.branch -cne $p.branch -or
        $h.source_snapshot.commit -cne $h.repository.expected_head -or $profile.source_commit -cne $h.source_snapshot.commit -or
        (@('document-ranges','isolated-document-test') -cnotcontains $p.stage -and $h.repository.expected_upstream_sha -cne $h.repository.expected_head)) { throw 'STOP: source snapshot cross-field mismatch.' }
    if ($h.policy_sha256 -cne (Get-AIOSHash ([IO.File]::ReadAllBytes($PolicyPath))) -or
        $h.project_profile.profile_sha256 -cne (Get-AIOSHash ([IO.File]::ReadAllBytes($ProfilePath))) -or
        $h.project_profile.id -cne $profile.id) { throw 'STOP: policy/profile hash mismatch.' }
    if ($h.executor_sha256 -cne (Get-AIOSHash ([IO.File]::ReadAllBytes($EntryPath)))) { throw 'STOP: executor hash mismatch.' }
    $dependencyNames = @('DocumentSafety.Core.ps1', 'Handoff.Core.ps1', 'StrictJson.cs', 'DOC-HANDOFF.schema.json')
    if ($h.executor_dependencies.Count -ne $dependencyNames.Count) { throw 'STOP: executor dependency set mismatch.' }
    foreach ($name in $dependencyNames) {
        $binding = @($h.executor_dependencies | Where-Object { $_.name -ceq $name })
        if ($binding.Count -ne 1) { throw 'STOP: executor dependency set mismatch.' }
        $path = Join-Path ([IO.Path]::GetDirectoryName($EntryPath)) $name
        Assert-AIOSExistingFile $path
        if ((Get-AIOSHash ([IO.File]::ReadAllBytes($path))) -cne $binding[0].sha256) { throw 'STOP: executor dependency hash mismatch.' }
    }
    if ([AIOSHandoff.StrictJson]::Canonical($h.sources) -cne [AIOSHandoff.StrictJson]::Canonical($profile.sources)) { throw 'STOP: source set differs from project profile.' }
    foreach ($category in @('naming', 'archiving', 'versioning')) {
        $key = $(if ($category -eq 'versioning') { 'version_source_paths' } elseif ($category -eq 'archiving') { 'archive_source_paths' } else { 'naming_source_paths' })
        if ([AIOSHandoff.StrictJson]::Canonical($h.project_profile[$key]) -cne [AIOSHandoff.StrictJson]::Canonical($profile[$category].source_paths)) { throw 'STOP: profile source references mismatch.' }
    }
    return [pscustomobject]@{ Handoff = $h; Policy = $p; Profile = $profile }
}

function Save-AIOSDurableContext {
    param([object]$Context, [string]$RecoveryRoot, [string]$CheckReportPath)
    Assert-AIOSTransactionScope $Context $RecoveryRoot
    $fresh = New-AIOSHandoffContext $Context.HandoffPath $Context.PolicyPath $Context.ProfilePath $Context.EntryPath $Context.HandoffHash
    if ($fresh.IndexHash -cne $Context.IndexHash -or $fresh.Root -cne $Context.Root) { throw 'STOP: context changed before durable capture.' }
    [void](Read-AIOSApprovedCheck $fresh $CheckReportPath (Get-AIOSHandoffPrediction $fresh))
    $parent = [IO.Path]::GetDirectoryName($fresh.Root)
    if ([IO.Path]::GetDirectoryName([IO.Path]::GetDirectoryName($CheckReportPath)) -cne $parent) { throw 'STOP: durable Check outside fixture parent.' }
    $d = [ordered]@{ format = 'AIOS-ISOLATED-DURABLE-CONTEXT/1.0'; scope = 'ISOLATED_TEST_ONLY';
        root = $fresh.Root; recovery_root = [IO.Path]::GetFullPath($RecoveryRoot); index_path = $fresh.IndexPath; index_sha256 = $fresh.IndexHash;
        handoff_path = $fresh.HandoffPath; handoff_sha256 = $fresh.HandoffHash; policy_path = $fresh.PolicyPath; profile_path = $fresh.ProfilePath;
        check_path = $CheckReportPath; check_sha256 = Get-AIOSHash ([IO.File]::ReadAllBytes($CheckReportPath));
        check_executor_sha256 = $fresh.Handoff.executor_sha256;
        transaction_module_sha256 = Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOStransactionModulePath));
        recovery_module_sha256 = Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOSrecoveryModulePath)) }
    $path = Join-Path $parent 'durable_context.json'
    Write-AIOSNewBytes $path (ConvertTo-AIOSBytes (ConvertTo-AIOSCanonicalJson $d))
    return [pscustomobject]@{ Path = $path; Hash = Get-AIOSHash ([IO.File]::ReadAllBytes($path)) }
}

function Read-AIOSDurableContext {
    param([string]$DescriptorPath, [string]$ExpectedDescriptorHash, [string]$EntryPath)
    # Descriptor location and pinned bytes precede every read of its referenced root.
    $base = [IO.Path]::GetFullPath((Join-Path ([IO.Path]::GetTempPath()) 'AIOS_CODEX_GATE_TESTS')).TrimEnd('\', '/')
    $descriptor = [IO.Path]::GetFullPath($DescriptorPath)
    if (-not $descriptor.StartsWith($base + '\', [StringComparison]::OrdinalIgnoreCase)) { throw 'STOP: descriptor outside isolated TEMP fixture.' }
    Assert-AIOSPlainDirectory ([IO.Path]::GetDirectoryName($descriptor))
    $d = Read-AIOSCanonicalJson $descriptor
    if ($ExpectedDescriptorHash -cnotmatch '^[0-9a-f]{64}$' -or (Get-AIOSHash ([IO.File]::ReadAllBytes($descriptor))) -cne $ExpectedDescriptorHash) { throw 'STOP: durable descriptor hash mismatch.' }
    Assert-AIOSFields $d @('format', 'scope', 'root', 'recovery_root', 'index_path', 'index_sha256', 'handoff_path', 'handoff_sha256', 'policy_path', 'profile_path', 'check_path', 'check_sha256', 'check_executor_sha256', 'transaction_module_sha256', 'recovery_module_sha256')
    foreach ($key in $d.Keys) { if ($d[$key] -isnot [string] -or [string]::IsNullOrWhiteSpace($d[$key]) -or $d[$key] -match '[\x00-\x1f]') { throw 'STOP: durable string field required.' } }
    if ($d.format -cne 'AIOS-ISOLATED-DURABLE-CONTEXT/1.0' -or $d.scope -cne 'ISOLATED_TEST_ONLY') { throw 'STOP: durable descriptor scope mismatch.' }
    foreach ($key in @('index_sha256','handoff_sha256','check_sha256','check_executor_sha256','transaction_module_sha256','recovery_module_sha256')) {
        if ($d[$key] -cnotmatch '^[0-9a-f]{64}$') { throw 'STOP: durable digest required.' }
    }
    # A minimal stub is sufficient to reject a production root before reading Git or any root file.
    $stub = [pscustomobject]@{ Root = $d.root; Policy = [pscustomobject]@{ stage = 'isolated-test'; origin_urls = @('C:\AIOS_GITHUB\AIOS_CORE') } }
    Assert-AIOSTransactionScope $stub $d.recovery_root
    $parent = [IO.Path]::GetDirectoryName($d.root)
    if ($descriptor -cne (Join-Path $parent 'durable_context.json')) { throw 'STOP: durable descriptor location mismatch.' }
    foreach ($pair in @(@('handoff_path','handoff.json'),@('policy_path','policy.json'),@('profile_path','profile.json'))) {
        if ($d[$pair[0]] -cne (Join-Path $parent $pair[1])) { throw 'STOP: durable input location mismatch.' }
    }
    $checkParent = [IO.Path]::GetDirectoryName($d.check_path)
    if ([IO.Path]::GetDirectoryName($checkParent) -cne $parent -or [IO.Path]::GetFileName($checkParent) -cnotmatch '^check_[0-9a-f]{32}$' -or
        [IO.Path]::GetFileName($d.check_path) -cne 'check_report.json') { throw 'STOP: durable Check location mismatch.' }
    Assert-AIOSPinnedEvidence $script:AIOSrecoveryModulePath $d.recovery_module_sha256
    Assert-AIOSPinnedEvidence $script:AIOStransactionModulePath $d.transaction_module_sha256
    Assert-AIOSPinnedEvidence $EntryPath $d.check_executor_sha256
    Assert-AIOSPlainDirectory $checkParent
    Assert-AIOSPinnedEvidence $d.check_path $d.check_sha256
    $inputs = Read-AIOSDurableInputs $d.handoff_path $d.policy_path $d.profile_path $EntryPath $d.handoff_sha256
    if ($inputs.Policy.stage -cne 'isolated-test' -or $inputs.Policy.root -cne $d.root -or $inputs.Handoff.executor_sha256 -cne $d.check_executor_sha256) { throw 'STOP: durable context cross-field mismatch.' }
    $seen = @{}
    foreach ($f in $inputs.Handoff.files) {
        Assert-AIOSRelativePath $f.path
        if ($seen.ContainsKey($f.path) -or $inputs.Policy.allowed_paths -cnotcontains $f.path -or $f.path -match '_v[0-9]+\.[0-9]+') { throw 'STOP: durable target scope mismatch.' }
        $seen[$f.path] = $true
    }
    $index = Read-AIOSGitOne $d.root @('rev-parse', '--path-format=absolute', '--git-path', 'index')
    if ($index -cne $d.index_path) { throw 'STOP: durable index location mismatch.' }
    $c = [pscustomobject]@{ Handoff = $inputs.Handoff; Policy = $inputs.Policy; Profile = $inputs.Profile; Root = $d.root;
        IndexPath = $index; IndexHash = $d.index_sha256; HandoffPath = $d.handoff_path; HandoffHash = $d.handoff_sha256;
        PolicyPath = $d.policy_path; ProfilePath = $d.profile_path; EntryPath = $EntryPath }
    Assert-AIOSTransactionScope $c $d.recovery_root
    Assert-AIOSTransactionBindings $c
    Assert-AIOSGitIdentity $c
    # This returns authenticated input context, not permission to write or a target-state attestation.
    # Ordinary transaction entries recheck target state; Read-AIOSAppliedRecovery validates full APPLIED state.
    return [pscustomobject]@{ Context = $c; Descriptor = $d; Path = $descriptor; Hash = $ExpectedDescriptorHash }
}

function Read-AIOSAppliedRecovery {
    param([object]$Durable, [string]$JournalPath, [string]$ExpectedJournalHash)
    $c = $Durable.Context; $d = $Durable.Descriptor
    Assert-AIOSPinnedEvidence $Durable.Path $Durable.Hash
    $directory = [IO.Path]::GetDirectoryName([IO.Path]::GetFullPath($JournalPath))
    if ([IO.Path]::GetDirectoryName($directory) -cne $d.recovery_root -or [IO.Path]::GetFileName($directory) -cnotmatch '^transaction_[0-9a-f]{32}$') { throw 'STOP: durable recovery location mismatch.' }
    Assert-AIOSPlainDirectory $directory
    Assert-AIOSPinnedEvidence $JournalPath $ExpectedJournalHash
    $j = Read-AIOSCanonicalJson $JournalPath
    Assert-AIOSFields $j @('format','state','sequence','previous_sha256','root','handoff_sha256','policy_sha256','profile_sha256','check_executor_sha256','transaction_module_sha256','head','index_sha256','apply_approval_sha256','rollback_approval_sha256','apply_diff_sha256','rollback_diff_sha256','files')
    if ($j.format -cne 'AIOS-ISOLATED-TRANSACTION/1.0' -or $j.state -cne 'APPLIED') { throw 'STOP: durable ordinary rollback requires APPLIED; partial recovery needs a separate plan.' }
    if ($j.root -cne $c.Root -or $j.handoff_sha256 -cne $c.HandoffHash -or $j.policy_sha256 -cne $c.Handoff.policy_sha256 -or
        $j.profile_sha256 -cne $c.Handoff.project_profile.profile_sha256 -or $j.check_executor_sha256 -cne $d.check_executor_sha256 -or
        $j.transaction_module_sha256 -cne $d.transaction_module_sha256 -or $j.index_sha256 -cne $c.IndexHash -or $j.head -cne $c.Handoff.repository.expected_head -or
        $j.files.Count -ne $c.Handoff.files.Count) { throw 'STOP: durable journal context mismatch.' }
    Assert-AIOSJournalChain $JournalPath $j
    Assert-AIOSRecoverySet $c $directory
    $prediction = @()
    for ($i = 0; $i -lt $c.Handoff.files.Count; $i++) {
        $f = $c.Handoff.files[$i]; $r = $j.files[$i]
        Assert-AIOSFields $r @('path','operation','pre_sha256','post_sha256','state')
        $preHash = $(if ($f.operation -ceq 'modify_ranges') { $f.pre_sha256 } else { '' })
        if ($r.path -cne $f.path -or $r.operation -cne $f.operation -or $r.pre_sha256 -cne $preHash -or $r.post_sha256 -cne $f.post_sha256 -or $r.state -cne 'APPLIED') { throw 'STOP: durable journal target mismatch.' }
        $before = [IO.File]::ReadAllBytes((Join-Path $directory ('{0:D3}_before.bin' -f $i)))
        $after = [IO.File]::ReadAllBytes((Join-Path $directory ('{0:D3}_post.bin' -f $i)))
        if ($f.operation -ceq 'modify_ranges') {
            $plan = [ordered]@{}
            foreach ($key in @('pre_sha256','post_sha256','encoding','eol','bom','final_newline','ranges','contains_once')) { $plan[$key] = $f[$key] }
            $rebuilt = New-AIOSPostimage $before $plan
            if ((Get-AIOSHash $rebuilt.Bytes) -cne (Get-AIOSHash $after)) { throw 'STOP: durable range reconstruction mismatch.' }
            Assert-AIOSMetricsEqual $rebuilt.BeforeMetrics $f.metrics_before
        } else {
            $rebuilt = ConvertTo-AIOSBytes $f.content_utf8 $f.eol $f.bom
            if ((Get-AIOSHash $rebuilt) -cne (Get-AIOSHash $after)) { throw 'STOP: durable creation reconstruction mismatch.' }
        }
        Assert-AIOSMetricsEqual (Get-AIOSMetrics $after) $f.metrics_expected
        $prediction += [pscustomobject]@{ File = $f; Before = $before; After = $after }
    }
    [void](Read-AIOSApprovedCheck $c $d.check_path $prediction)
    $diff = Join-Path $directory 'apply.final.diff.txt'
    Assert-AIOSPinnedEvidence $diff $j.apply_diff_sha256
    $text = (New-Object Text.UTF8Encoding($false,$true)).GetString([IO.File]::ReadAllBytes($diff))
    $sections = @($text -split '(?m)^TARGET: ')
    if ($sections.Count -ne ($prediction.Count + 1) -or $sections[0] -cne "AIOS isolated transaction evidence: APPLY`n") { throw 'STOP: durable actual diff structure mismatch.' }
    for ($i = 0; $i -lt $prediction.Count; $i++) {
        $item = $prediction[$i]; $header = $item.File.path + ' / ' + $item.File.operation + "`n"; $section = $sections[$i+1]
        if (-not $section.StartsWith($header,[StringComparison]::Ordinal)) { throw 'STOP: durable actual diff target mismatch.' }
        Assert-AIOSDiffRoundTrip @($section.Substring($header.Length).TrimEnd("`n") -split "`n") $item.Before $item.After
    }
    Assert-AIOSTransactionState $c ([bool[]]@(foreach ($f in $c.Handoff.files) { $true }))
    Assert-AIOSPinnedEvidence $Durable.Path $Durable.Hash
    return ,$j
}
