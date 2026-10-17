[CmdletBinding()]
param(
 [Parameter(Mandatory=$true)][string]$ExpectedWrapperSha256,
 [Parameter(Mandatory=$true)][string]$ExpectedProjectSha256,
 [ValidateSet('Info','Check','Apply')][string]$Mode='Info',
 [string]$ActionPath='', [string]$ExpectedActionSha256='',
 [string]$ExternallyApprovedActionSha256=''
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Assert-Pin([string]$File,[string]$Pin){
 if($Pin -cnotmatch '^[0-9a-f]{64}$'){throw 'PIN_INVALID'}
 $cursor=[IO.Path]::GetFullPath($File)
 while($cursor){$item=Get-Item -LiteralPath $cursor -Force;if(($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0){throw 'REPARSE_POINT'};$cursor=[IO.Path]::GetDirectoryName($cursor)}
 if((Get-FileHash -LiteralPath $File -Algorithm SHA256).Hash.ToLowerInvariant() -cne $Pin){throw 'PIN_MISMATCH'}
}
function Assert-Fields($Object,$Names){
 $actual=@($Object.PSObject.Properties.Name|Sort-Object)
 $expected=@($Names|Sort-Object)
 if(($actual -join '|') -cne ($expected -join '|')){throw 'FIELDS_INVALID'}
}
if($PSVersionTable.PSEdition -ne 'Desktop' -or $PSVersionTable.PSVersion.Major -ne 5 -or $PSVersionTable.PSVersion.Minor -ne 1){throw 'WINDOWS_POWERSHELL_51_REQUIRED'}
if($ExecutionContext.SessionState.LanguageMode -ne 'FullLanguage'){throw 'FULL_LANGUAGE_REQUIRED'}
if((Get-ExecutionPolicy) -ne 'RemoteSigned'){throw 'REMOTE_SIGNED_REQUIRED'}
Assert-Pin $PSCommandPath $ExpectedWrapperSha256
$projectFile=Join-Path $PSScriptRoot 'document-workflow\project.json'
Assert-Pin $projectFile $ExpectedProjectSha256
$p=Get-Content -LiteralPath $projectFile -Raw -Encoding UTF8|ConvertFrom-Json
Assert-Fields $p @('format','project','root','catalog','profile','admission')
if($p.format -cne 'AIOS-DOCUMENT-PROJECT-LINK/0.6'){throw 'PROJECT_LINK_FORMAT'}
$expectedWrapper=Join-Path $p.root 'tools\codex\Invoke-DocumentWorkflow.ps1'
if($PSCommandPath -ine $expectedWrapper -or (Get-Location).Path -ine $p.root){throw 'PROJECT_ROOT_MISMATCH'}
foreach($ref in @($p.catalog,$p.profile,$p.admission)){Assert-Fields $ref @('path','sha256');Assert-Pin $ref.path $ref.sha256}
if($p.profile.path -ine (Join-Path $PSScriptRoot 'document-workflow\profile.json') -or $p.admission.path -ine (Join-Path $PSScriptRoot 'document-workflow\admission.json')){throw 'PROJECT_DATA_PATH'}
$profile=Get-Content -LiteralPath $p.profile.path -Raw -Encoding UTF8|ConvertFrom-Json
$admission=Get-Content -LiteralPath $p.admission.path -Raw -Encoding UTF8|ConvertFrom-Json
if($profile.project -cne $p.project -or $profile.root -ine $p.root -or $admission.project -cne $p.project -or $admission.root -ine $p.root -or $admission.document_profile_sha256 -cne $p.profile.sha256){throw 'PROJECT_IDENTITY_MISMATCH'}
$catalog=Get-Content -LiteralPath $p.catalog.path -Raw -Encoding UTF8|ConvertFrom-Json
Assert-Fields $catalog @('format','release_id','base','code','launcher','python','qualification','production_ready')
if($catalog.format -cne 'AIOS-COMMON-DOCUMENT-RELEASE/0.6' -or $catalog.production_ready -ne $false){throw 'CATALOG_FORMAT'}
$expectedNames=@('approved_action.py','approved_verify.py','execution_guard.py','review_gate.py','source_guard.py','workflow.py')
if(@($catalog.code).Count -ne $expectedNames.Count){throw 'COMMON_CODE_SET'}
for($i=0;$i -lt $expectedNames.Count;$i++){
 $ref=$catalog.code[$i];Assert-Fields $ref @('path','sha256')
 if([IO.Path]::GetFileName($ref.path) -cne $expectedNames[$i]){throw 'COMMON_CODE_ROLE'}
 Assert-Pin $ref.path $ref.sha256
}
foreach($ref in @($catalog.launcher,$catalog.python,$catalog.qualification)){Assert-Fields $ref @('path','sha256');Assert-Pin $ref.path $ref.sha256}
$launcher=Join-Path $catalog.base 'document_activation_v0_5_20261016\Invoke-ApprovedDocumentAction.ps1'
if($catalog.launcher.path -ine $launcher){throw 'COMMON_LAUNCHER_PATH'}
$q=Get-Content -LiteralPath $catalog.qualification.path -Raw -Encoding UTF8|ConvertFrom-Json
if($q.format -cne 'AIOS-ACTIVATION-QUALIFICATION/0.6' -or $q.failed -ne 0 -or $q.passed -lt 24){throw 'COMMON_QUALIFICATION_NOT_PASS'}
if($Mode -eq 'Info'){
 if($ActionPath -cne '' -or $ExpectedActionSha256 -cne '' -or $ExternallyApprovedActionSha256 -cne ''){throw 'INFO_HAS_NO_ACTION'}
 [ordered]@{format='AIOS-DOCUMENT-WORKFLOW-INFO/0.6';state='PROJECT_LINK_BYTES_VERIFIED';project=$p.project;root=$p.root;release=$catalog.release_id;permissions_name=$admission.permissions_name;document_write_executed=$false;session_permissions_attested=$false;production_ready=$false}|ConvertTo-Json
 return
}
Assert-Pin $ActionPath $ExpectedActionSha256
$action=Get-Content -LiteralPath $ActionPath -Raw -Encoding UTF8|ConvertFrom-Json
if($action.project -cne $p.project -or $action.root -ine $p.root){throw 'ACTION_PROJECT_MISMATCH'}
Assert-Pin $action.release.path $action.release.sha256
$release=Get-Content -LiteralPath $action.release.path -Raw -Encoding UTF8|ConvertFrom-Json
if($release.project_admission.path -ine $p.admission.path -or $release.project_admission.sha256 -cne $p.admission.sha256 -or $release.qualification.path -ine $catalog.qualification.path -or $release.qualification.sha256 -cne $catalog.qualification.sha256){throw 'ACTION_RELEASE_LINK_MISMATCH'}
if($Mode -eq 'Apply' -and $ExternallyApprovedActionSha256 -cne $ExpectedActionSha256){throw 'EXTERNAL_EXACT_ACTION_APPROVAL_REQUIRED'}
if($Mode -eq 'Check' -and $ExternallyApprovedActionSha256 -cne ''){throw 'CHECK_DOES_NOT_CONSUME_APPROVAL'}
& $launcher -ExpectedLauncherSha256 $catalog.launcher.sha256 -Mode $Mode -ExecutionScope RepositoryAssisted -ActionPath $ActionPath -ExpectedActionSha256 $ExpectedActionSha256 -ExternallyApprovedActionSha256 $ExternallyApprovedActionSha256
