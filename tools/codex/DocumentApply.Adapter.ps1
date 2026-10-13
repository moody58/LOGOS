# Durable entrypoint bridge R2.2; document range lane and exact dirty snapshot.
# ProductionScope.Adapter provides root, document, baseline and approval seams.
Set-StrictMode -Version 2.0
$script:AIOSAdapterPath = $PSCommandPath
$script:AIOSOriginalRemote = ${function:Assert-AIOSRemote}
$script:AIOSOfflineCheck = $null
$script:AIOSActiveDescriptorHash = ''


function Assert-AIOSEntrypointExternal {
    param([string]$Root,[string]$Path)
    $full = [IO.Path]::GetFullPath($Path)
    if ($Path -cne $full -or $full -ieq $Root -or $full.StartsWith($Root+'\',[StringComparison]::OrdinalIgnoreCase)) { throw 'STOP: entrypoint evidence must be external and absolute.' }
    Assert-AIOSPlainDirectory ([IO.Path]::GetDirectoryName($full))
    Assert-AIOSExistingFile $full
}

function Assert-AIOSTransactionScope {
    param([object]$Context,[string]$RecoveryRoot)
    Assert-AIOSEntrypointRoot $Context.Root $RecoveryRoot
    Assert-AIOSEntrypointDocument $Context
}
function Assert-AIOSRemote {
    param([object]$Context)
    if ($script:AIOSExecutionScope -ceq 'LOGOSDocument') {
        if ($Context.Root -cne 'C:\AIOS_GITHUB\LOGOS') { throw 'STOP: LOGOS local tracking root mismatch.' }
        Assert-AIOSGitIdentity $Context
        # Local origin/main observation only; this does not attest live remote state.
        return
    }
    if ($null -eq $script:AIOSOfflineCheck) { & $script:AIOSOriginalRemote $Context; return }
    # Check performed the origin read. Apply/Verify/Rollback use its pinned evidence.
    # No ls-remote, fetch, network, or mutable remote-tracking refresh during writes.
    Assert-AIOSPinnedEvidence $script:AIOSOfflineCheck.Path $script:AIOSOfflineCheck.Hash
    $r=Read-AIOSCanonicalJson $script:AIOSOfflineCheck.Path
    if ($r.handoff_sha256 -cne $Context.HandoffHash -or $r.root -cne $Context.Root -or
        $r.remote_sha -cne $Context.Handoff.repository.expected_upstream_sha) { throw 'STOP: offline remote evidence mismatch.' }
}

function New-AIOSEntrypointContext {
    param([string]$HandoffPath,[string]$PolicyPath,[string]$ProfilePath,[string]$EntryPath,[string]$HandoffHash,
        [string]$RecoveryRoot,[string]$BaselinePath,[string]$BaselineHash,[string]$IndexHash='',[bool]$AllowTargetPost=$false)
    # Read and pin inputs, then reject scope before any Git or root-file access.
    $inputs=Read-AIOSDurableInputs $HandoffPath $PolicyPath $ProfilePath $EntryPath $HandoffHash
    Assert-AIOSEntrypointRoot $inputs.Policy.root $RecoveryRoot
    Assert-AIOSEntrypointDocument $inputs
    $parent=[IO.Path]::GetDirectoryName($RecoveryRoot)
    foreach($pair in @(@($HandoffPath,'handoff.json'),@($PolicyPath,'policy.json'),@($ProfilePath,'profile.json'))){
        if($pair[0] -cne (Join-Path $parent $pair[1])){throw 'STOP: entrypoint input location mismatch.'}
        Assert-AIOSEntrypointExternal $inputs.Policy.root $pair[0]
    }
    if($script:AIOSExecutionScope -ceq 'IsolatedTest'){Assert-AIOSEntrypointExternal $inputs.Policy.root $EntryPath}
    Read-AIOSEntrypointBaseline $BaselinePath $BaselineHash $inputs.Policy.root $RecoveryRoot $inputs.Handoff $AllowTargetPost
    if($IndexHash -ceq ''){$IndexHash=$script:AIOSBaseline.index_sha256}
    if($IndexHash -cne $script:AIOSBaseline.index_sha256){throw 'STOP: baseline/index pin mismatch.'}
    $index=Read-AIOSGitOne $inputs.Policy.root @('rev-parse','--path-format=absolute','--git-path','index')
    Assert-AIOSExistingFile $index
    $c=[pscustomobject]@{Root=$inputs.Policy.root;Handoff=$inputs.Handoff;Policy=$inputs.Policy;Profile=$inputs.Profile;
        IndexPath=$index;IndexHash=$IndexHash;HandoffPath=$HandoffPath;HandoffHash=$HandoffHash;
        PolicyPath=$PolicyPath;ProfilePath=$ProfilePath;EntryPath=$EntryPath}
    Assert-AIOSTransactionBindings $c
    Assert-AIOSGitIdentity $c
    return $c
}
function Save-AIOSEntrypointDescriptor {
    param([object]$Context,[string]$RecoveryRoot,[string]$CheckPath)
    Assert-AIOSTransactionScope $Context $RecoveryRoot
    [void](Read-AIOSApprovedCheck $Context $CheckPath (Get-AIOSHandoffPrediction $Context))
    $d=[ordered]@{format='AIOS-ENTRYPOINT-CONTEXT/2.1';scope=$script:AIOSExecutionScope;root=$Context.Root;
        recovery_root=$RecoveryRoot;index_path=$Context.IndexPath;index_sha256=$Context.IndexHash;
        handoff_path=$Context.HandoffPath;handoff_sha256=$Context.HandoffHash;policy_path=$Context.PolicyPath;
        profile_path=$Context.ProfilePath;check_path=$CheckPath;check_sha256=Get-AIOSHash ([IO.File]::ReadAllBytes($CheckPath));
        check_executor_sha256=$Context.Handoff.executor_sha256;
        transaction_module_sha256=Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOStransactionModulePath));
        recovery_module_sha256=Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOSrecoveryModulePath));
        adapter_sha256=Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOSAdapterPath));
        production_adapter_sha256=Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOSProductionAdapterPath));
        baseline_path=$script:AIOSBaselinePath;baseline_sha256=$script:AIOSBaselineHash}
    $path=Join-Path ([IO.Path]::GetDirectoryName($CheckPath)) 'entrypoint_context.json'
    Write-AIOSNewBytes $path (ConvertTo-AIOSBytes (ConvertTo-AIOSCanonicalJson $d))
    return [pscustomobject]@{Path=$path;Hash=Get-AIOSHash ([IO.File]::ReadAllBytes($path))}
}
function Read-AIOSEntrypointDescriptor {
    param([string]$Path,[string]$Hash,[string]$EntryPath)
    Assert-AIOSPinnedEvidence $Path $Hash
    $d=Read-AIOSCanonicalJson $Path
    Assert-AIOSFields $d @('format','scope','root','recovery_root','index_path','index_sha256','handoff_path','handoff_sha256',
        'policy_path','profile_path','check_path','check_sha256','check_executor_sha256','transaction_module_sha256',
        'recovery_module_sha256','adapter_sha256','production_adapter_sha256','baseline_path','baseline_sha256')
    foreach($key in $d.Keys){if($d[$key] -isnot [string] -or [string]::IsNullOrWhiteSpace($d[$key]) -or $d[$key] -match '[\x00-\x1f]'){throw 'STOP: entrypoint descriptor string required.'}}
    if($d.format -cne 'AIOS-ENTRYPOINT-CONTEXT/2.1' -or $d.scope -cne $script:AIOSExecutionScope){throw 'STOP: entrypoint descriptor scope mismatch.'}
    Assert-AIOSEntrypointRoot $d.root $d.recovery_root
    $parent=[IO.Path]::GetDirectoryName($d.recovery_root)
    $checkParent=[IO.Path]::GetDirectoryName($d.check_path)
    if([IO.Path]::GetDirectoryName($checkParent) -cne $parent -or [IO.Path]::GetFileName($checkParent) -cnotmatch '^check_[0-9a-f]{32}$' -or
        $Path -cne (Join-Path $checkParent 'entrypoint_context.json') -or [IO.Path]::GetFileName($d.check_path) -cne 'check_report.json'){throw 'STOP: entrypoint descriptor location mismatch.'}
    foreach($pair in @(@('handoff_path','handoff.json'),@('policy_path','policy.json'),@('profile_path','profile.json'))){
        if($d[$pair[0]] -cne (Join-Path $parent $pair[1])){throw 'STOP: entrypoint input location mismatch.'}
    }
    Assert-AIOSPinnedEvidence $EntryPath $d.check_executor_sha256
    Assert-AIOSPinnedEvidence $script:AIOStransactionModulePath $d.transaction_module_sha256
    Assert-AIOSPinnedEvidence $script:AIOSrecoveryModulePath $d.recovery_module_sha256
    Assert-AIOSPinnedEvidence $script:AIOSAdapterPath $d.adapter_sha256
    Assert-AIOSPinnedEvidence $script:AIOSProductionAdapterPath $d.production_adapter_sha256
    Assert-AIOSEntrypointExternal $d.root $Path
    Assert-AIOSEntrypointExternal $d.root $d.check_path
    Assert-AIOSPinnedEvidence $d.check_path $d.check_sha256
    $script:AIOSOfflineCheck=[pscustomobject]@{Path=$d.check_path;Hash=$d.check_sha256}
    $script:AIOSActiveDescriptorHash=$Hash
    $c=New-AIOSEntrypointContext $d.handoff_path $d.policy_path $d.profile_path $EntryPath $d.handoff_sha256 $d.recovery_root $d.baseline_path $d.baseline_sha256 $d.index_sha256 $true
    if($c.IndexPath -cne $d.index_path){throw 'STOP: entrypoint index location mismatch.'}
    return [pscustomobject]@{Context=$c;Descriptor=$d;Path=$Path;Hash=$Hash}
}
