# Release candidate: installed real scope or isolated approval fixtures.
# Durable reservation; human origin remains an external observation.
Set-StrictMode -Version 2.0

function Assert-AIOSApprovalFixture {
    param([string]$Root)
    # Reject real roots before path resolution, disk access or native helpers.
    if($Root.StartsWith('C:\AIOS_GITHUB',[StringComparison]::OrdinalIgnoreCase)){
        if($script:AIOSExecutionScope -cne 'LOGOSDocument' -or $Root -cne 'C:\AIOS_GITHUB\LOGOS' -or $PSScriptRoot -cne 'C:\AIOS_GITHUB\LOGOS\tools\codex' -or $null -eq $script:AIOSReleaseActivation){throw 'STOP: installed activated approval bridge required.'}
        Assert-AIOSPlainDirectory $Root;return
    }
    $approvalBase=Join-Path ([IO.Path]::GetTempPath()) 'LOGOS_R22_APPROVAL_TESTS'
    $bridgeBase=Join-Path ([IO.Path]::GetTempPath()) 'LOGOS_CODEX_ENTRYPOINT_TESTS'
    $standalone=($Root.StartsWith($approvalBase+'\',[StringComparison]::OrdinalIgnoreCase) -and
        $Root.Substring($approvalBase.Length+1) -cmatch '^[0-9a-f]{32}\\cases\\A[0-9]{2}\\repo$')
    $bridge=($Root.StartsWith($bridgeBase+'\',[StringComparison]::OrdinalIgnoreCase) -and
        $Root.Substring($bridgeBase.Length+1) -cmatch '^[0-9a-f]{32}\\[0-9a-f]{32}\\repo$')
    if(-not $standalone -and -not $bridge){throw 'STOP: approval candidate is isolated-only.'}
    if($Root -cne [IO.Path]::GetFullPath($Root)){throw 'STOP: normalized approval fixture required.'}
    Assert-AIOSPlainDirectory $Root
    if($bridge){$marker=Join-Path ([IO.Path]::GetDirectoryName($Root)) '_AIOS_ISOLATED_FIXTURE.txt';$identity='LOGOS_ENTRYPOINT_TEST_ONLY'}
    else{$marker=Join-Path $Root '_APPROVAL_FIXTURE.txt';$identity='ISOLATED_APPROVAL_PROTOCOL_ONLY'}
    Assert-AIOSExistingFile $marker
    if([IO.File]::ReadAllText($marker) -cne $identity){throw 'STOP: approval fixture identity mismatch.'}
}
function Read-AIOSApprovalPinnedJson {
    param([string]$Path,[string]$ExpectedSha256)
    if($ExpectedSha256 -cnotmatch '^[0-9a-f]{64}$'){throw 'STOP: externally reviewed pin required.'}
    Assert-AIOSExistingFile $Path
    if((Get-Item -LiteralPath $Path -Force).Length -gt 131072){throw 'STOP: approval input size limit.'}
    $bytes=[IO.File]::ReadAllBytes($Path)
    if((Get-AIOSHash $bytes) -cne $ExpectedSha256){throw 'STOP: approval input pin mismatch.'}
    return ,([AIOSHandoff.StrictJson]::ParseCanonical($bytes))
}
function Assert-AIOSApprovalText {
    param([object]$Value,[string]$Label)
    if($Value -isnot [string] -or [string]::IsNullOrWhiteSpace($Value) -or $Value.Length -gt 512 -or
        $Value -match '[\x00-\x1f]'){throw ('STOP: invalid approval metadata: '+$Label)}
}
function Read-AIOSApprovalProtocol {
    param([string]$Root,[string]$RequestPath,[string]$ExpectedRequestSha256,
          [string]$DecisionPath,[string]$ExternallyApprovedDecisionSha256,
          [ValidateSet('Apply','Rollback')][string]$Action)
    Assert-AIOSApprovalFixture $Root
    $outer=[IO.Path]::GetDirectoryName($Root)
    $real=$Root -ceq 'C:\AIOS_GITHUB\LOGOS'
    if($real){$outer='C:\AIOS_MIGRAZIONE\LOGOS_DOCUMENT_APPROVALS'}
    $bridgeBase=Join-Path ([IO.Path]::GetTempPath()) 'LOGOS_CODEX_ENTRYPOINT_TESTS'
    $bridge=$Root.StartsWith($bridgeBase+'\',[StringComparison]::OrdinalIgnoreCase)
    $expectedTarget='document.md'
    if($bridge -or $real){
        $inputs=[IO.Path]::GetDirectoryName($RequestPath)
        $approvalBase=$(if($real){$outer}else{Join-Path $outer 'approvals'})
        if(-not $inputs.StartsWith($approvalBase+'\',[StringComparison]::Ordinal) -or
            $inputs.Substring($approvalBase.Length+1) -cnotmatch '^[0-9a-f]{32}$'){throw 'STOP: approval input location mismatch.'}
        if($null -eq $script:AIOSBaselineTarget){throw 'STOP: transaction context required before document approval.'}
        $expectedTarget=$script:AIOSBaselineTarget.path
    }else{$inputs=Join-Path $outer 'inputs'}
    # Exact locations prevent approval/input aliases and arbitrary file reads.
    if($RequestPath -cne (Join-Path $inputs 'request.json') -or $DecisionPath -cne (Join-Path $inputs 'decision.json')){
        throw 'STOP: approval input location mismatch.'
    }
    $r=Read-AIOSApprovalPinnedJson $RequestPath $ExpectedRequestSha256
    $d=Read-AIOSApprovalPinnedJson $DecisionPath $ExternallyApprovedDecisionSha256
    Assert-AIOSFields $r @('format','scope','request_id','action','root','target','state_sha256','artifacts')
    Assert-AIOSFields $d @('format','scope','request_sha256','action','status','approved_by','approved_utc','chat_reference')
    foreach($k in $d.Keys){Assert-AIOSApprovalText $d[$k] $k}
    foreach($k in @('format','scope','request_id','action','root','target','state_sha256')){Assert-AIOSApprovalText $r[$k] $k}
    if($r.format -cne 'AIOS-ACTION-REVIEW/1.0' -or $d.format -cne 'AIOS-HUMAN-DECISION/1.0' -or
        $r.scope -cne $(if($real){'LOGOS_DOCUMENT_RANGES_ONLY'}else{'ISOLATED_APPROVAL_PROTOCOL_ONLY'}) -or $d.scope -cne $r.scope -or
        $r.request_id -cnotmatch '^[0-9a-f]{32}$' -or $r.root -cne $Root -or
        $r.action -cne $Action -or $d.action -cne $Action -or
        $d.request_sha256 -cne $ExpectedRequestSha256){throw 'STOP: approval action/request binding mismatch.'}
    if($d.status -cne 'APPROVED' -or $d.approved_by -cne 'user'){throw 'STOP: explicit human decision required.'}
    if($d.approved_utc -cnotmatch '^20[0-9]{2}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$'){
        throw 'STOP: approval timestamp invalid.'
    }
    try{$date=[DateTimeOffset]::ParseExact($d.approved_utc,"yyyy-MM-dd'T'HH:mm:ss'Z'",[Globalization.CultureInfo]::InvariantCulture,[Globalization.DateTimeStyles]::AssumeUniversal)}
    catch{throw 'STOP: approval timestamp invalid.'}
    if($date -gt [DateTimeOffset]::UtcNow){throw 'STOP: approval timestamp is in the future.'}
    if((($bridge -or $real) -and $r.request_id -cne [IO.Path]::GetFileName($inputs)) -or $r.target -cne $expectedTarget -or $r.state_sha256 -cnotmatch '^[0-9a-f]{64}$'){
        throw 'STOP: approval fixture target mismatch.'
    }
    $target=$(if($bridge -or $real){Resolve-AIOSDocumentPath $Root $expectedTarget}else{Join-Path $Root $expectedTarget});Assert-AIOSExistingFile $target
    if((Get-AIOSHash ([IO.File]::ReadAllBytes($target))) -cne $r.state_sha256){throw 'STOP: approval state changed.'}
    $labels=@('handoff','policy','profile','baseline','descriptor','check','entrypoint','adapter','transaction','diff','command_plan','journal')
    if($r.artifacts -isnot [array] -or $r.artifacts.Count -ne $labels.Count){throw 'STOP: approval artifact set mismatch.'}
    $seen=@{}
    foreach($a in $r.artifacts){
        Assert-AIOSFields $a @('label','sha256')
        if($a.label -isnot [string] -or $labels -cnotcontains $a.label -or $seen.ContainsKey($a.label) -or
            $a.sha256 -isnot [string] -or $a.sha256 -cnotmatch '^[0-9a-f]{64}$'){throw 'STOP: approval artifact set mismatch.'}
        $seen[$a.label]=$true
        $path=Join-Path $inputs ($a.label+'.bin');Assert-AIOSExistingFile $path
        if((Get-AIOSHash ([IO.File]::ReadAllBytes($path))) -cne $a.sha256){throw ('STOP: approval evidence changed: '+$a.label)}
    }
    # Read pins again after evidence validation. No cached object can authorize a later reservation.
    [void](Read-AIOSApprovalPinnedJson $RequestPath $ExpectedRequestSha256)
    [void](Read-AIOSApprovalPinnedJson $DecisionPath $ExternallyApprovedDecisionSha256)
    return [pscustomobject]@{request_id=$r.request_id;action=$Action;root=$Root;
        request_sha256=$ExpectedRequestSha256;decision_sha256=$ExternallyApprovedDecisionSha256;
        human_origin_attested=$false;scope=$(if($Root -ceq 'C:\AIOS_GITHUB\LOGOS'){'LOGOS_DOCUMENT_RANGES_ONLY'}else{'ISOLATED_APPROVAL_PROTOCOL_ONLY'})}
}
function Reserve-AIOSApprovalProtocol {
    param([string]$Root,[string]$RequestPath,[string]$ExpectedRequestSha256,
          [string]$DecisionPath,[string]$ExternallyApprovedDecisionSha256,
          [ValidateSet('Apply','Rollback')][string]$Action)
    Assert-AIOSApprovalFixture $Root
    # Same root identity as the future transaction mutex. No transaction is executed here.
    $mutex=New-Object Threading.Mutex($false,('Local\AIOS_DOCUMENT_TRANSACTION_'+(Get-AIOSHash (ConvertTo-AIOSBytes $Root.ToLowerInvariant()))))
    $owned=$false
    try{
        $owned=$mutex.WaitOne(0)
        if(-not $owned){throw 'STOP: approval root mutex is busy.'}
        $valid=Read-AIOSApprovalProtocol $Root $RequestPath $ExpectedRequestSha256 $DecisionPath $ExternallyApprovedDecisionSha256 $Action
        $claims=$(if($Root -ceq 'C:\AIOS_GITHUB\LOGOS'){'C:\AIOS_MIGRAZIONE\LOGOS_DOCUMENT_APPROVALS\claims'}else{Join-Path ([IO.Path]::GetDirectoryName($Root)) 'claims'});Assert-AIOSPlainDirectory $claims
        $claimPath=Join-Path $claims ($valid.request_id+'.json')
        if(Test-Path -LiteralPath $claimPath){throw 'STOP: approval request already reserved; no automatic retry.'}
        $record=[ordered]@{format='AIOS-APPROVAL-RESERVATION/1.0';scope=$(if($Root -ceq 'C:\AIOS_GITHUB\LOGOS'){'LOGOS_DOCUMENT_RANGES_ONLY'}else{'ISOLATED_APPROVAL_PROTOCOL_ONLY'});
            state='RESERVED';request_id=$valid.request_id;action=$Action;root=$Root;
            request_sha256=$ExpectedRequestSha256;decision_sha256=$ExternallyApprovedDecisionSha256;
            reserved_utc=[DateTime]::UtcNow.ToString("yyyy-MM-dd'T'HH:mm:ss'Z'");
            target_written=$false;real_apply_enabled=$false}
        # CreateNew rejects a competing reservation. Preserve even a partially created record.
        Write-AIOSNewBytes $claimPath (ConvertTo-AIOSBytes (ConvertTo-AIOSCanonicalJson $record))
        return [pscustomobject]@{path=$claimPath;sha256=(Get-AIOSHash ([IO.File]::ReadAllBytes($claimPath)));
            state='RESERVED';target_written=$false;real_apply_enabled=$false;production_ready=$false}
    }finally{if($owned){$mutex.ReleaseMutex()};$mutex.Dispose()}
}
