# Candidate integration. WRITE SUPPORT IS RESTRICTED TO VERIFIED TEMP FIXTURES.
# No production Apply interface, commits, pushes, deletes, or automatic rollback.
Set-StrictMode -Version 2.0
$script:AIOStransactionModulePath = $PSCommandPath

function Assert-AIOSTransactionScope {
    param([object]$Context, [string]$RecoveryRoot)
    # Reject production roots BEFORE opening their files or reading Git.
    $root = [IO.Path]::GetFullPath($Context.Root).TrimEnd('\', '/')
    $base = [IO.Path]::GetFullPath((Join-Path ([IO.Path]::GetTempPath()) 'AIOS_CODEX_GATE_TESTS')).TrimEnd('\', '/')
    if (-not $root.StartsWith($base + '\', [StringComparison]::OrdinalIgnoreCase) -or $Context.Policy.stage -cne 'isolated-test') { throw 'STOP: transaction writes require an isolated TEMP fixture.' }
    $parent = [IO.Path]::GetDirectoryName($root)
    Assert-AIOSPlainDirectory $parent
    $marker = Join-Path $parent '_AIOS_ISOLATED_FIXTURE.txt'
    Assert-AIOSExistingFile $marker
    if ([IO.File]::ReadAllText($marker) -cne 'AIOS_ISOLATED_TEST_ONLY') { throw 'STOP: isolated transaction identity missing.' }
    Assert-AIOSPlainDirectory $root
    Assert-AIOSPlainDirectory $RecoveryRoot
    $recovery = [IO.Path]::GetFullPath($RecoveryRoot).TrimEnd('\', '/')
    if ($recovery -cne (Join-Path $parent 'recovery') -or [IO.Path]::GetPathRoot($recovery) -cne [IO.Path]::GetPathRoot($root)) { throw 'STOP: recovery must be the fixture sibling on the same volume.' }
    if ($Context.Policy.origin_urls.Count -ne 1 -or $Context.Policy.origin_urls[0] -cne 'C:\AIOS_GITHUB\AIOS_CORE') { throw 'STOP: transaction fixture origin mismatch.' }
}
function Assert-AIOSTransactionBindings {
    param([object]$Context)
    foreach ($binding in @(
        @($Context.HandoffPath, $Context.HandoffHash),
        @($Context.PolicyPath, $Context.Handoff.policy_sha256),
        @($Context.ProfilePath, $Context.Handoff.project_profile.profile_sha256),
        @($Context.EntryPath, $Context.Handoff.executor_sha256)
    )) {
        Assert-AIOSExistingFile $binding[0]
        if ((Get-AIOSHash ([IO.File]::ReadAllBytes($binding[0]))) -cne $binding[1]) { throw 'STOP: transaction input changed.' }
    }
    if ((Get-AIOSHash (ConvertTo-AIOSBytes ([AIOSHandoff.StrictJson]::Canonical($Context.Handoff)))) -cne $Context.HandoffHash) { throw 'STOP: in-memory handoff changed.' }
    if ((Get-AIOSHash (ConvertTo-AIOSBytes ([AIOSHandoff.StrictJson]::Canonical($Context.Policy)))) -cne $Context.Handoff.policy_sha256 -or
        (Get-AIOSHash (ConvertTo-AIOSBytes ([AIOSHandoff.StrictJson]::Canonical($Context.Profile)))) -cne $Context.Handoff.project_profile.profile_sha256) { throw 'STOP: in-memory profile/policy changed.' }
    foreach ($binding in $Context.Handoff.executor_dependencies) {
        $path = Join-Path ([IO.Path]::GetDirectoryName($Context.EntryPath)) $binding.name
        Assert-AIOSExistingFile $path
        if ((Get-AIOSHash ([IO.File]::ReadAllBytes($path))) -cne $binding.sha256) { throw 'STOP: transaction dependency changed.' }
    }
}
function Read-AIOSFixtureApproval {
    param([object]$Context, [string]$Path, [string]$ExpectedSha256, [string]$Action, [string]$EvidencePath, [string]$EvidenceHash)
    Assert-AIOSPlainDirectory ([IO.Path]::GetDirectoryName([IO.Path]::GetFullPath($Path)))
    if ([IO.Path]::GetFullPath($Path).StartsWith($Context.Root + '\', [StringComparison]::OrdinalIgnoreCase)) { throw 'STOP: approval must remain outside repository.' }
    $a = Read-AIOSCanonicalJson $Path
    if ($ExpectedSha256 -cnotmatch '^[0-9a-f]{64}$' -or (Get-AIOSHash ([IO.File]::ReadAllBytes($Path))) -cne $ExpectedSha256) { throw 'STOP: fixture approval hash mismatch.' }
    Assert-AIOSFields $a @('format', 'scope', 'action', 'root', 'handoff_sha256', 'policy_sha256', 'profile_sha256', 'check_executor_sha256', 'transaction_module_sha256', 'evidence_path', 'evidence_sha256')
    foreach ($name in $a.Keys) { if ($a[$name] -isnot [string]) { throw 'STOP: approval string fields required.' } }
    if ($a.format -cne 'AIOS-ISOLATED-APPROVAL/1.0' -or $a.scope -cne 'ISOLATED_TEST_ONLY' -or $a.action -cne $Action -or
        $a.root -cne $Context.Root -or $a.handoff_sha256 -cne $Context.HandoffHash -or
        $a.policy_sha256 -cne $Context.Handoff.policy_sha256 -or $a.profile_sha256 -cne $Context.Handoff.project_profile.profile_sha256 -or
        $a.check_executor_sha256 -cne $Context.Handoff.executor_sha256 -or
        $a.transaction_module_sha256 -cne (Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOStransactionModulePath))) -or
        $a.evidence_path -cne [IO.Path]::GetFullPath($EvidencePath) -or $a.evidence_sha256 -cne $EvidenceHash) { throw 'STOP: fixture approval binding mismatch.' }
    return ,$a
}
function Assert-AIOSPinnedEvidence {
    param([string]$Path, [string]$Hash)
    Assert-AIOSExistingFile $Path
    if ((Get-AIOSHash ([IO.File]::ReadAllBytes($Path))) -cne $Hash) { throw 'STOP: pinned approval/evidence changed.' }
}
function Assert-AIOSIgnoredPaths {
    param([object]$Context)
    foreach ($row in (Read-AIOSGit $Context.Root @('status', '--porcelain=v1', '--untracked-files=all', '--ignored=matching'))) {
        if (([string]$row).StartsWith('!! ', [StringComparison]::Ordinal)) { throw 'STOP: foreign ignored paths in transaction fixture.' }
    }
}
function Assert-AIOSTransactionState {
    param([object]$Context, [bool[]]$Applied)
    Assert-AIOSTransactionBindings $Context
    Assert-AIOSGitIdentity $Context
    $expected = @(); $appliedPaths = @()
    if ($Applied.Count -ne $Context.Handoff.files.Count) { throw 'STOP: transaction state cardinality mismatch.' }
    for ($i = 0; $i -lt $Applied.Count; $i++) {
        $f = $Context.Handoff.files[$i]
        if ($Applied[$i]) {
            $path = Resolve-AIOSDocumentPath $Context.Root $f.path
            if ((Get-AIOSHash ([IO.File]::ReadAllBytes($path))) -cne $f.post_sha256) { throw 'STOP: applied target changed.' }
            $expected += $(if ($f.operation -ceq 'create_text') { '?? ' } else { ' M ' }) + $f.path
            $appliedPaths += $f.path
        } elseif ($f.operation -ceq 'create_text') {
            [void](Resolve-AIOSDocumentPath $Context.Root $f.path $false)
        } else {
            $path = Resolve-AIOSDocumentPath $Context.Root $f.path
            if ((Get-AIOSHash ([IO.File]::ReadAllBytes($path))) -cne $f.pre_sha256) { throw 'STOP: preimage changed during transaction.' }
        }
    }
    Assert-AIOSStatus $Context.Root $expected $appliedPaths
    Assert-AIOSIgnoredPaths $Context
    Assert-AIOSSourceGuard $Context $appliedPaths
    Assert-AIOSRemote $Context
}
function Read-AIOSApprovedCheck {
    param([object]$Context, [string]$ReportPath, [object[]]$Prediction)
    Assert-AIOSPlainDirectory ([IO.Path]::GetDirectoryName([IO.Path]::GetFullPath($ReportPath)))
    if ([IO.Path]::GetFullPath($ReportPath).StartsWith($Context.Root + '\', [StringComparison]::OrdinalIgnoreCase)) { throw 'STOP: Check evidence must be external.' }
    $r = Read-AIOSCanonicalJson $ReportPath
    Assert-AIOSFields $r @('collected_utc', 'cqd_semantic_review', 'effective_codex_permissions', 'files', 'handoff_sha256', 'head', 'index_unchanged', 'predicted_diff_path', 'predicted_diff_roundtrip', 'predicted_diff_sha256', 'production_ready', 'protocol', 'remote_sha', 'repository_documents_written', 'result', 'root')
    if ($r.protocol -cne 'AIOS-DOC-HANDOFF-CHECK/0.3' -or $r.result -cne 'PASS_CHECK_ONLY' -or $r.root -cne $Context.Root -or
        $r.handoff_sha256 -cne $Context.HandoffHash -or $r.head -cne $Context.Handoff.repository.expected_head -or
        $r.remote_sha -cne $Context.Handoff.repository.expected_upstream_sha -or $r.predicted_diff_roundtrip -cne 'PASS' -or
        $r.index_unchanged -isnot [bool] -or -not $r.index_unchanged -or $r.production_ready -isnot [bool] -or $r.production_ready -or
        $r.repository_documents_written -ne 0 -or $r.files.Count -ne $Prediction.Count) { throw 'STOP: Check report differs from approved context.' }
    $parent = [IO.Path]::GetDirectoryName([IO.Path]::GetFullPath($ReportPath))
    if ($r.predicted_diff_path -cne (Join-Path $parent 'predicted.diff.txt')) { throw 'STOP: Check diff location mismatch.' }
    Assert-AIOSExistingFile $r.predicted_diff_path
    if ((Get-AIOSHash ([IO.File]::ReadAllBytes($r.predicted_diff_path))) -cne $r.predicted_diff_sha256) { throw 'STOP: Check diff changed.' }
    $diffText = (New-Object Text.UTF8Encoding($false, $true)).GetString([IO.File]::ReadAllBytes($r.predicted_diff_path))
    $sections = @($diffText -split '(?m)^TARGET: ')
    if ($sections.Count -ne ($Prediction.Count + 1) -or $sections[0] -cne "AIOS DOC-HANDOFF: predicted diff only. No repository documents written.`n") { throw 'STOP: Check diff structure mismatch.' }
    for ($i = 0; $i -lt $Prediction.Count; $i++) {
        $p = $Prediction[$i]; $f = $r.files[$i]
        Assert-AIOSFields $f @('metrics', 'operation', 'path', 'predicted_sha256')
        if ($f.path -cne $p.File.path -or $f.operation -cne $p.File.operation -or $f.predicted_sha256 -cne $p.File.post_sha256) { throw 'STOP: Check file binding mismatch.' }
        Assert-AIOSMetricsEqual $f.metrics $p.File.metrics_expected
        if ($f.metrics.sha256 -cne $p.File.post_sha256) { throw 'STOP: Check metric hash mismatch.' }
        $section = $sections[$i + 1]
        $header = $p.File.path + ' / ' + $p.File.operation + "`n"
        if (-not $section.StartsWith($header, [StringComparison]::Ordinal)) { throw 'STOP: Check target order mismatch.' }
        $body = $section.Substring($header.Length).TrimEnd("`n")
        Assert-AIOSDiffRoundTrip @($body -split "`n") $p.Before $p.After
    }
    return ,$r
}
function Save-AIOSTransactionJournal {
    param([string]$Directory, [object]$Journal, [string]$PreviousHash)
    if ($Journal.sequence -ge 0) {
        Assert-AIOSPinnedEvidence (Join-Path $Directory ('{0:D3}_journal.json' -f [int]$Journal.sequence)) $PreviousHash
    }
    $Journal.sequence = $Journal.sequence + 1
    $Journal.previous_sha256 = $PreviousHash
    $path = Join-Path $Directory ('{0:D3}_journal.json' -f [int]$Journal.sequence)
    Write-AIOSNewBytes $path (ConvertTo-AIOSBytes (ConvertTo-AIOSCanonicalJson $Journal))
    return [pscustomobject]@{ Path = $path; Hash = Get-AIOSHash ([IO.File]::ReadAllBytes($path)) }
}
function Assert-AIOSRecoverySet {
    param([object]$Context, [string]$Directory)
    Assert-AIOSPlainDirectory $Directory
    for ($i = 0; $i -lt $Context.Handoff.files.Count; $i++) {
        $f = $Context.Handoff.files[$i]
        $beforePath = Join-Path $Directory ('{0:D3}_before.bin' -f $i)
        $postPath = Join-Path $Directory ('{0:D3}_post.bin' -f $i)
        Assert-AIOSExistingFile $beforePath; Assert-AIOSExistingFile $postPath
        $before = [IO.File]::ReadAllBytes($beforePath); $post = [IO.File]::ReadAllBytes($postPath)
        if (($f.operation -ceq 'modify_ranges' -and (Get-AIOSHash $before) -cne $f.pre_sha256) -or
            ($f.operation -ceq 'create_text' -and $before.Length -ne 0) -or (Get-AIOSHash $post) -cne $f.post_sha256) { throw 'STOP: recovery backup hash mismatch.' }
    }
}
function Assert-AIOSJournalChain {
    param([string]$JournalPath, [object]$Journal)
    $directory = [IO.Path]::GetDirectoryName([IO.Path]::GetFullPath($JournalPath))
    if ([IO.Path]::GetFileName($JournalPath) -cne ('{0:D3}_journal.json' -f [int]$Journal.sequence) -or $Journal.sequence -lt 0 -or $Journal.sequence -gt 256) { throw 'STOP: journal sequence mismatch.' }
    if (Test-Path -LiteralPath (Join-Path $directory ('{0:D3}_journal.json' -f ([int]$Journal.sequence + 1)))) { throw 'STOP: journal is no longer latest.' }
    $current = $Journal
    for ($i = [int]$Journal.sequence; $i -ge 0; $i--) {
        if ($current.sequence -ne $i) { throw 'STOP: journal chain sequence mismatch.' }
        if ($i -eq 0) { if ($current.previous_sha256 -cne '') { throw 'STOP: journal chain start mismatch.' }; break }
        $prior = Join-Path $directory ('{0:D3}_journal.json' -f ($i - 1))
        Assert-AIOSExistingFile $prior
        if ((Get-AIOSHash ([IO.File]::ReadAllBytes($prior))) -cne $current.previous_sha256) { throw 'STOP: journal history changed.' }
        $current = Read-AIOSCanonicalJson $prior
    }
}
function Write-AIOSTransactionDiff {
    param([object]$Context, [string]$Directory, [ValidateSet('APPLY', 'ROLLBACK')][string]$Action)
    $diff = @('AIOS isolated transaction evidence: ' + $Action)
    for ($i = 0; $i -lt $Context.Handoff.files.Count; $i++) {
        $f = $Context.Handoff.files[$i]
        $beforePath = Join-Path $Directory ('{0:D3}_before.bin' -f $i)
        $postPath = Join-Path $Directory ('{0:D3}_post.bin' -f $i)
        $before = [IO.File]::ReadAllBytes($beforePath); $post = [IO.File]::ReadAllBytes($postPath)
        if ($Action -ceq 'APPLY') {
            $target = Resolve-AIOSDocumentPath $Context.Root $f.path
            # Actual delta is the acquired local preimage, including approved
            # dirty changes, versus the real target. Git/index is a separate guard.
            $rows = Read-AIOSGit $Context.Root @('diff', '--no-ext-diff', '--no-textconv', '--no-index', '--', $beforePath, $target) @(0, 1) @('core.autocrlf=false', 'core.eol=lf', 'core.safecrlf=false')
            Assert-AIOSDocumentDeltaWhitespace $Context.Root $beforePath $target $rows
            if ((Get-AIOSHash ([IO.File]::ReadAllBytes($target))) -cne $f.post_sha256) { throw 'STOP: actual diff target hash mismatch.' }
            Assert-AIOSDiffRoundTrip $rows $before $post
        } else {
            $restoredPath = $beforePath
            if ($f.operation -ceq 'modify_ranges') { $restoredPath = Resolve-AIOSDocumentPath $Context.Root $f.path }
            $rows = Read-AIOSGit $Context.Root @('diff', '--no-ext-diff', '--no-textconv', '--no-index', '--', $postPath, $restoredPath) @(0, 1) @('core.autocrlf=false', 'core.eol=lf', 'core.safecrlf=false')
            Assert-AIOSDiffRoundTrip $rows $post $before
        }
        $diff += ('TARGET: ' + $f.path + ' / ' + $f.operation); $diff += $rows
    }
    if ($Action -ceq 'APPLY') {
        # Global Git identity/index/status is validated by the transaction state
        # guard; delta whitespace was checked against the local preimage above.
        Assert-AIOSGitIdentity $Context
    } else {
        # Rollback restores the approved working preimage, not a clean Git tree.
        Assert-AIOSStatus $Context.Root @()
    }
    $path = Join-Path $Directory ($Action.ToLowerInvariant() + '.final.diff.txt')
    Write-AIOSNewBytes $path (ConvertTo-AIOSBytes (($diff -join "`n") + "`n"))
    return [pscustomobject]@{ Path = $path; Hash = Get-AIOSHash ([IO.File]::ReadAllBytes($path)) }
}
function Invoke-AIOSIsolatedTransactionApply {
    param([object]$Context, [string]$RecoveryRoot, [string]$CheckReportPath, [string]$ApprovalPath, [string]$ApprovedApprovalSha256,
        [ValidateSet('NONE', 'AFTER_FIRST_WRITE')][string]$TestFault = 'NONE', [scriptblock]$TestAfterFirstWrite = {})
    Assert-AIOSTransactionScope $Context $RecoveryRoot
    $mutex = New-Object Threading.Mutex($false, ('Local\AIOS_DOCUMENT_TRANSACTION_' + (Get-AIOSHash (ConvertTo-AIOSBytes $Context.Root.ToLowerInvariant()))))
    $owned = $false
    try {
        $owned = $mutex.WaitOne(0)
        if (-not $owned) { throw 'STOP: another transaction owns this fixture.' }
        Assert-AIOSTransactionBindings $Context
        $prediction = Get-AIOSHandoffPrediction $Context
        $checkHash = Get-AIOSHash ([IO.File]::ReadAllBytes($CheckReportPath))
        $check = Read-AIOSApprovedCheck $Context $CheckReportPath $prediction
        $approval = Read-AIOSFixtureApproval $Context $ApprovalPath $ApprovedApprovalSha256 'APPLY' $CheckReportPath $checkHash
        Assert-AIOSPinnedEvidence $CheckReportPath $checkHash
        $states = [bool[]]@(foreach ($f in $prediction) { $false })
        Assert-AIOSTransactionState $Context $states
        $transaction = Join-Path $RecoveryRoot ('transaction_' + [Guid]::NewGuid().ToString('N'))
        [void][IO.Directory]::CreateDirectory($transaction); Assert-AIOSPlainDirectory $transaction
        $records = @()
        for ($i = 0; $i -lt $prediction.Count; $i++) {
            $r = $prediction[$i]
            Write-AIOSNewBytes (Join-Path $transaction ('{0:D3}_before.bin' -f $i)) $r.Before
            Write-AIOSNewBytes (Join-Path $transaction ('{0:D3}_post.bin' -f $i)) $r.After
            $records += [ordered]@{ path = $r.File.path; operation = $r.File.operation;
                pre_sha256 = $(if ($r.File.operation -ceq 'modify_ranges') { $r.File.pre_sha256 } else { '' });
                post_sha256 = $r.File.post_sha256; state = 'PREPARED' }
        }
        $j = [ordered]@{ format = 'AIOS-ISOLATED-TRANSACTION/1.0'; state = 'PREPARED'; sequence = -1; previous_sha256 = '';
            root = $Context.Root; handoff_sha256 = $Context.HandoffHash; policy_sha256 = $Context.Handoff.policy_sha256;
            profile_sha256 = $Context.Handoff.project_profile.profile_sha256; check_executor_sha256 = $Context.Handoff.executor_sha256;
            transaction_module_sha256 = Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOStransactionModulePath));
            head = $Context.Handoff.repository.expected_head; index_sha256 = $Context.IndexHash; apply_approval_sha256 = $ApprovedApprovalSha256;
            rollback_approval_sha256 = ''; apply_diff_sha256 = ''; rollback_diff_sha256 = ''; files = $records }
        $saved = Save-AIOSTransactionJournal $transaction $j ''
        try {
            for ($i = 0; $i -lt $prediction.Count; $i++) {
                Assert-AIOSTransactionState $Context $states
                Assert-AIOSRecoverySet $Context $transaction
                Assert-AIOSPinnedEvidence $ApprovalPath $ApprovedApprovalSha256
                Assert-AIOSPinnedEvidence $CheckReportPath $checkHash
                Assert-AIOSPinnedEvidence $check.predicted_diff_path $check.predicted_diff_sha256
                Assert-AIOSPinnedEvidence $script:AIOStransactionModulePath $approval.transaction_module_sha256
                $r = $prediction[$i]
                $staged = Join-Path $transaction ('{0:D3}_apply_staged.bin' -f $i)
                Write-AIOSNewBytes $staged $r.After
                $j.state = 'APPLYING'; $j.files[$i].state = 'WRITE_INTENT'
                $saved = Save-AIOSTransactionJournal $transaction $j $saved.Hash
                $target = Resolve-AIOSDocumentPath $Context.Root $r.File.path ($r.File.operation -ceq 'modify_ranges')
                $parent = [IO.Path]::GetDirectoryName($target)
                if (-not [IO.Directory]::Exists($parent)) {
                    $relativeParent = $r.File.path.Substring(0, $r.File.path.LastIndexOf('/'))
                    if ($Context.Policy.allowed_new_directories -cnotcontains $relativeParent) { throw 'STOP: new parent directory outside allowlist.' }
                    [void][IO.Directory]::CreateDirectory($parent)
                }
                Assert-AIOSPlainDirectory $parent
                # Re-check all files and Git after staging/journaling, immediately before write.
                Assert-AIOSTransactionState $Context $states
                Assert-AIOSRecoverySet $Context $transaction
                Assert-AIOSPinnedEvidence $ApprovalPath $ApprovedApprovalSha256
                Assert-AIOSPinnedEvidence $CheckReportPath $checkHash
                Assert-AIOSPinnedEvidence $check.predicted_diff_path $check.predicted_diff_sha256
                if ($r.File.operation -ceq 'modify_ranges') {
                    [AIOSCandidateNative.FileGuard]::ReplaceWithoutExtraBackup($staged, $target)
                } else { [IO.File]::Move($staged, $target) }
                $states[$i] = $true
                Assert-AIOSMetricsEqual (Get-AIOSMetrics ([IO.File]::ReadAllBytes($target))) $r.File.metrics_expected
                Assert-AIOSTransactionState $Context $states
                $j.files[$i].state = 'APPLIED'; $saved = Save-AIOSTransactionJournal $transaction $j $saved.Hash
                if ($i -eq 0) {
                    & $TestAfterFirstWrite $Context $transaction $ApprovalPath | Out-Null
                    if ($TestFault -ceq 'AFTER_FIRST_WRITE') { throw 'STOP: injected interruption after first Apply write.' }
                }
            }
            $proof = Write-AIOSTransactionDiff $Context $transaction 'APPLY'
            Assert-AIOSTransactionState $Context $states
            Assert-AIOSRecoverySet $Context $transaction
            $j.apply_diff_sha256 = $proof.Hash; $j.state = 'APPLIED'; $saved = Save-AIOSTransactionJournal $transaction $j $saved.Hash
        } catch {
            $j.state = 'PARTIAL_APPLY'; $saved = Save-AIOSTransactionJournal $transaction $j $saved.Hash
            throw ('STOP: partial fixture Apply; no automatic undo. Recovery: ' + $transaction + '. ' + $_.Exception.Message)
        }
        return [pscustomobject]@{ state = 'APPLIED'; journal_path = $saved.Path; journal_sha256 = $saved.Hash;
            final_diff_path = $proof.Path; final_diff_sha256 = $proof.Hash; index_unchanged = $true; production_ready = $false }
    } finally { if ($owned) { $mutex.ReleaseMutex() }; $mutex.Dispose() }
}
function Invoke-AIOSIsolatedTransactionRollback {
    param([object]$Context, [string]$RecoveryRoot, [string]$JournalPath, [string]$ApprovalPath, [string]$ApprovedApprovalSha256,
        [ValidateSet('NONE', 'AFTER_FIRST_WRITE')][string]$TestFault = 'NONE', [scriptblock]$TestAfterFirstWrite = {})
    Assert-AIOSTransactionScope $Context $RecoveryRoot
    $mutex = New-Object Threading.Mutex($false, ('Local\AIOS_DOCUMENT_TRANSACTION_' + (Get-AIOSHash (ConvertTo-AIOSBytes $Context.Root.ToLowerInvariant()))))
    $owned = $false
    try {
        $owned = $mutex.WaitOne(0)
        if (-not $owned) { throw 'STOP: another transaction owns this fixture.' }
        Assert-AIOSTransactionBindings $Context
        $transaction = [IO.Path]::GetDirectoryName([IO.Path]::GetFullPath($JournalPath))
        Assert-AIOSPlainDirectory $transaction
        if ([IO.Path]::GetDirectoryName($transaction) -cne [IO.Path]::GetFullPath($RecoveryRoot) -or [IO.Path]::GetFileName($transaction) -cnotmatch '^transaction_[0-9a-f]{32}$') { throw 'STOP: rollback recovery location mismatch.' }
        $j = Read-AIOSCanonicalJson $JournalPath
        Assert-AIOSFields $j @('format', 'state', 'sequence', 'previous_sha256', 'root', 'handoff_sha256', 'policy_sha256', 'profile_sha256', 'check_executor_sha256', 'transaction_module_sha256', 'head', 'index_sha256', 'apply_approval_sha256', 'rollback_approval_sha256', 'apply_diff_sha256', 'rollback_diff_sha256', 'files')
        if ($j.format -cne 'AIOS-ISOLATED-TRANSACTION/1.0' -or $j.state -cne 'APPLIED' -or $j.root -cne $Context.Root -or
            $j.handoff_sha256 -cne $Context.HandoffHash -or $j.policy_sha256 -cne $Context.Handoff.policy_sha256 -or
            $j.profile_sha256 -cne $Context.Handoff.project_profile.profile_sha256 -or $j.check_executor_sha256 -cne $Context.Handoff.executor_sha256 -or
            $j.transaction_module_sha256 -cne (Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOStransactionModulePath))) -or
            $j.head -cne $Context.Handoff.repository.expected_head -or $j.index_sha256 -cne $Context.IndexHash -or $j.files.Count -ne $Context.Handoff.files.Count) { throw 'STOP: rollback journal identity/state mismatch.' }
        $approvedJournalHash = Get-AIOSHash ([IO.File]::ReadAllBytes($JournalPath))
        $approval = Read-AIOSFixtureApproval $Context $ApprovalPath $ApprovedApprovalSha256 'ROLLBACK' $JournalPath $approvedJournalHash
        Assert-AIOSPinnedEvidence $JournalPath $approvedJournalHash
        Assert-AIOSJournalChain $JournalPath $j
        $applyDiff = Join-Path $transaction 'apply.final.diff.txt'; Assert-AIOSExistingFile $applyDiff
        if ((Get-AIOSHash ([IO.File]::ReadAllBytes($applyDiff))) -cne $j.apply_diff_sha256) { throw 'STOP: Apply diff evidence changed.' }
        $states = [bool[]]@(foreach ($f in $j.files) { $true })
        Assert-AIOSTransactionState $Context $states
        # All backups and all postimages must validate BEFORE the first write.
        $prepared = @()
        for ($i = 0; $i -lt $j.files.Count; $i++) {
            $r = $j.files[$i]; $f = $Context.Handoff.files[$i]
            Assert-AIOSFields $r @('path', 'operation', 'pre_sha256', 'post_sha256', 'state')
            $expectedPre = $(if ($f.operation -ceq 'modify_ranges') { $f.pre_sha256 } else { '' })
            if ($r.path -cne $f.path -or $r.operation -cne $f.operation -or $r.pre_sha256 -cne $expectedPre -or $r.post_sha256 -cne $f.post_sha256 -or $r.state -cne 'APPLIED') { throw 'STOP: rollback file identity mismatch.' }
            $beforePath = Join-Path $transaction ('{0:D3}_before.bin' -f $i); $postPath = Join-Path $transaction ('{0:D3}_post.bin' -f $i)
            Assert-AIOSExistingFile $beforePath; Assert-AIOSExistingFile $postPath
            $before = [IO.File]::ReadAllBytes($beforePath); $post = [IO.File]::ReadAllBytes($postPath)
            if (($f.operation -ceq 'modify_ranges' -and (Get-AIOSHash $before) -cne $f.pre_sha256) -or
                ($f.operation -ceq 'create_text' -and $before.Length -ne 0) -or (Get-AIOSHash $post) -cne $f.post_sha256) { throw 'STOP: recovery backup hash mismatch.' }
            $prepared += [pscustomobject]@{ Before = $before; BeforePath = $beforePath; PostPath = $postPath }
        }
        $saved = [pscustomobject]@{ Path = $JournalPath; Hash = Get-AIOSHash ([IO.File]::ReadAllBytes($JournalPath)) }
        try {
            for ($i = 0; $i -lt $j.files.Count; $i++) {
                Assert-AIOSTransactionState $Context $states
                Assert-AIOSRecoverySet $Context $transaction
                Assert-AIOSPinnedEvidence $ApprovalPath $ApprovedApprovalSha256
                Assert-AIOSPinnedEvidence $JournalPath $approvedJournalHash
                Assert-AIOSPinnedEvidence $applyDiff $j.apply_diff_sha256
                Assert-AIOSPinnedEvidence $script:AIOStransactionModulePath $approval.transaction_module_sha256
                $f = $Context.Handoff.files[$i]; $r = $prepared[$i]
                if ((Get-AIOSHash ([IO.File]::ReadAllBytes($r.BeforePath))) -cne (Get-AIOSHash $r.Before) -or
                    (Get-AIOSHash ([IO.File]::ReadAllBytes($r.PostPath))) -cne $f.post_sha256) { throw 'STOP: recovery changed immediately before rollback.' }
                $j.state = 'ROLLING_BACK'; $j.rollback_approval_sha256 = $ApprovedApprovalSha256; $j.files[$i].state = 'RESTORE_INTENT'
                $saved = Save-AIOSTransactionJournal $transaction $j $saved.Hash
                $target = Resolve-AIOSDocumentPath $Context.Root $f.path
                if ($f.operation -ceq 'modify_ranges') {
                    $staged = Join-Path $transaction ('{0:D3}_rollback_staged.bin' -f $i)
                    Write-AIOSNewBytes $staged $r.Before
                    Assert-AIOSTransactionState $Context $states
                    Assert-AIOSRecoverySet $Context $transaction
                    [AIOSCandidateNative.FileGuard]::ReplaceWithoutExtraBackup($staged, $target)
                } else {
                    Assert-AIOSTransactionState $Context $states
                    Assert-AIOSRecoverySet $Context $transaction
                    # Preserve the newly created document outside the repo; never delete it.
                    [IO.File]::Move($target, (Join-Path $transaction ('{0:D3}_created_preserved.md' -f $i)))
                }
                $states[$i] = $false
                Assert-AIOSTransactionState $Context $states
                $j.files[$i].state = 'ROLLED_BACK'; $saved = Save-AIOSTransactionJournal $transaction $j $saved.Hash
                if ($i -eq 0) {
                    & $TestAfterFirstWrite $Context $transaction $ApprovalPath | Out-Null
                    if ($TestFault -ceq 'AFTER_FIRST_WRITE') { throw 'STOP: injected interruption after first rollback write.' }
                }
            }
            $proof = Write-AIOSTransactionDiff $Context $transaction 'ROLLBACK'
            Assert-AIOSTransactionState $Context $states
            Assert-AIOSRecoverySet $Context $transaction
            $j.rollback_diff_sha256 = $proof.Hash; $j.state = 'ROLLED_BACK'; $saved = Save-AIOSTransactionJournal $transaction $j $saved.Hash
        } catch {
            $j.state = 'PARTIAL_ROLLBACK'; $saved = Save-AIOSTransactionJournal $transaction $j $saved.Hash
            throw ('STOP: partial fixture rollback; no automatic retry. Recovery: ' + $transaction + '. ' + $_.Exception.Message)
        }
        return [pscustomobject]@{ state = 'ROLLED_BACK'; journal_path = $saved.Path; journal_sha256 = $saved.Hash;
            final_diff_path = $proof.Path; final_diff_sha256 = $proof.Hash; index_unchanged = $true; backups_preserved = $true; production_ready = $false }
    } finally { if ($owned) { $mutex.ReleaseMutex() }; $mutex.Dispose() }
}
