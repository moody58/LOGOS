# R2.2 candidate: exact dirty snapshot + a single document range lane.
# This module never installs code, changes configuration or adopts a baseline.
Set-StrictMode -Version 2.0
$script:AIOSProductionAdapterPath=$PSCommandPath
$script:AIOSOriginalStatus=${function:Assert-AIOSStatus}
$script:AIOSOriginalIgnoredPaths=${function:Assert-AIOSIgnoredPaths}
$script:AIOSBaseline=$null
$script:AIOSBaselineTarget=$null
$script:AIOSBaselinePath='';$script:AIOSBaselineHash=''
$script:AIOSDocumentTarget=$null
$script:AIOSBaselineTargetStatus=''
$script:AIOSOriginalGitIdentity=${function:Assert-AIOSGitIdentity}
$script:AIOSLoadedRuntimePins=@{}
$script:AIOSInstalledNames=@('DocumentSafety.Core.ps1','Handoff.Core.ps1','StrictJson.cs','DOC-HANDOFF.schema.json',
    'Transaction.Core.ps1','Recovery.Core.ps1','DocumentApply.Adapter.ps1','ProductionScope.Adapter.ps1','Invoke-AIOSDocumentApply.ps1','Invoke-AIOSApprovedAction.ps1','ApprovalProtocol.Core.ps1')
$script:AIOSReleaseActivation=$null
$script:AIOSApprovedBridgeLease=$null

foreach($name in $script:AIOSInstalledNames){
    $runtimePath=Join-Path $PSScriptRoot $name
    $script:AIOSLoadedRuntimePins[$name]=Get-AIOSHash ([IO.File]::ReadAllBytes($runtimePath))
}

function Assert-AIOSEntrypointRoot {
    param([string]$Root,[string]$RecoveryRoot)
    # Duplicate the release gate at the module seam: dot-sourcing the candidate
    # must not turn the declared future real scope into an enabled write lane.
    if(@('IsolatedTest','LOGOSDocument') -cnotcontains $script:AIOSExecutionScope){throw 'STOP: legacy pilot lane is suspended.'}
    $full=[IO.Path]::GetFullPath($Root).TrimEnd('\','/')
    if($Root -cne $full){throw 'STOP: normalized root required.'}
    if($script:AIOSExecutionScope -ceq 'LOGOSDocument'){
        if($null -eq $script:AIOSReleaseActivation){throw 'STOP: verified release setup required.'}
        Assert-AIOSPinnedEvidence $script:AIOSReleaseActivation.path $script:AIOSReleaseActivation.sha256
        if($PSScriptRoot -cne 'C:\AIOS_GITHUB\LOGOS\tools\codex'){throw 'STOP: production module must be installed.'}
        if($full -cne 'C:\AIOS_GITHUB\LOGOS' -or $script:AIOSRunningEntryPath -cne
            'C:\AIOS_GITHUB\LOGOS\tools\codex\Invoke-AIOSDocumentApply.ps1'){throw 'STOP: production root/installed entrypoint mismatch.'}
        $outer=[IO.Path]::GetDirectoryName($RecoveryRoot)
        $prefix='C:\AIOS_MIGRAZIONE\LOGOS_DOCUMENT_APPLY_EVIDENCE'
        if(-not $outer.StartsWith($prefix+'\',[StringComparison]::Ordinal) -or
            $outer.Substring($prefix.Length+1) -cnotmatch '^[0-9a-f]{32}$' -or
            $RecoveryRoot -cne (Join-Path $outer 'recovery')){throw 'STOP: production recovery must be the dedicated external directory.'}
    }elseif($script:AIOSExecutionScope -ceq 'IsolatedTest'){
        $base=[IO.Path]::GetFullPath((Join-Path ([IO.Path]::GetTempPath()) 'LOGOS_CODEX_ENTRYPOINT_TESTS')).TrimEnd('\','/')
        if(-not $full.StartsWith($base+'\',[StringComparison]::OrdinalIgnoreCase) -or $full.Substring($base.Length+1) -cnotmatch '^[0-9a-f]{32}\\[0-9a-f]{32}\\repo$'){
            throw 'STOP: entrypoint requires an isolated TEMP root; real Apply is disabled in test scope.'
        }
        $outer=[IO.Path]::GetDirectoryName($full)
        Assert-AIOSPlainDirectory $outer
        $marker=Join-Path $outer '_AIOS_ISOLATED_FIXTURE.txt';Assert-AIOSExistingFile $marker
        if([IO.File]::ReadAllText($marker) -cne 'LOGOS_ENTRYPOINT_TEST_ONLY'){throw 'STOP: isolated identity mismatch.'}
        # Each run has immutable inputs/evidence. Permit a UUID run workspace
        # under the same fixture, without widening the synthetic root boundary.
        $runParent=[IO.Path]::GetDirectoryName($RecoveryRoot)
        $runs=Join-Path $outer 'runs'
        $legacy=$RecoveryRoot -ceq (Join-Path $outer 'recovery')
        $perRun=([IO.Path]::GetDirectoryName($runParent) -ceq $runs -and
            [IO.Path]::GetFileName($runParent) -cmatch '^[0-9a-f]{32}$' -and $RecoveryRoot -ceq (Join-Path $runParent 'recovery'))
        if(-not $legacy -and -not $perRun){throw 'STOP: isolated per-run recovery mismatch.'}
    }else{throw 'STOP: legacy pilot lane is suspended.'}
    Assert-AIOSPlainDirectory $full;Assert-AIOSPlainDirectory $RecoveryRoot
    Assert-AIOSPlainDirectory ([IO.Path]::GetDirectoryName($RecoveryRoot))
    if([IO.Path]::GetPathRoot($full) -cne [IO.Path]::GetPathRoot($RecoveryRoot)){throw 'STOP: recovery must be on the same volume.'}
}
function Assert-AIOSEntrypointDocument {
    param([object]$Inputs)
    $h=$Inputs.Handoff;$p=$Inputs.Policy
    $stage=$(if($script:AIOSExecutionScope -ceq 'LOGOSDocument'){'document-ranges'}else{'isolated-document-test'})
    if($p.stage -cne $stage -or $p.project -cne 'LOGOS' -or $p.repository -cne 'moody58/LOGOS' -or
        $p.branch -cne 'main' -or $h.files.Count -ne 1 -or $p.allowed_paths.Count -ne 1 -or
        $h.files[0].path -cne $p.allowed_paths[0] -or
        $h.files[0].operation -cne 'modify_ranges' -or $h.files[0].pre_sha256 -ceq $h.files[0].post_sha256 -or
        $p.allowed_new_directories.Count -ne 0){throw 'STOP: P1 permits one existing policy-authorized document, modify_ranges only.'}
    Assert-AIOSRelativePath $h.files[0].path
    # These immediate directories have the complete instruction inventory below.
    # No arbitrary nested path, tool, configuration or other project is enabled.
    if($h.files[0].path -cnotmatch '^98_SISTEMA_TECNICO/98_PROJECT_RUNTIME\.md$'){
        throw 'STOP: target outside the reviewed LOGOS runtime document.'
    }
    if($null -ne $script:AIOSBaseline -and $h.files[0].path -cne $script:AIOSBaselineTarget.path){throw 'STOP: active baseline target changed.'}
    $script:AIOSDocumentTarget=$h.files[0].path
    $semantic=@($p.instruction_files | Where-Object {$_.ContainsKey('guard')})
    if($semantic.Count -ne 1){throw 'STOP: exactly one semantic user configuration record required.'}
    if($script:AIOSExecutionScope -ceq 'LOGOSDocument'){
        $origins=@('https://github.com/moody58/LOGOS.git','https://github.com/moody58/LOGOS','git@github.com:moody58/LOGOS.git','ssh://git@github.com/moody58/LOGOS.git')
        if($p.origin_urls.Count -ne 1 -or $origins -cnotcontains $p.origin_urls[0]){
            throw 'STOP: production repository/source snapshot mismatch.'
        }
        Assert-AIOSProductionInstructions $p
    }else{
        $parent=[IO.Path]::GetDirectoryName($p.root);$seed=Join-Path $parent 'seed.git'
        if($p.origin_urls.Count -ne 1 -or $p.origin_urls[0] -cne $seed -or
            $semantic[0].path -cne (Join-Path $parent 'synthetic_global.toml')){throw 'STOP: synthetic sibling origin/configuration required.'}
        Assert-AIOSPlainDirectory $seed
    }
    if(-not [string]::IsNullOrEmpty($env:CODEX_HOME)){throw 'STOP: CODEX_HOME override requires a separately reviewed profile.'}
    Assert-AIOSCodexSemanticConfig (Join-Path $p.root '.codex\config.toml') $p.root 'Project'
    Assert-AIOSCodexSemanticConfig $semantic[0].path $p.root 'User'
}
function Assert-AIOSProductionInstructions {
    param([object]$Policy)
    # Presence and all non-user-config hashes are policy/baseline pins. Only the
    # user config has a semantic guard; its acquisition hash remains evidence.
    $expected=@{'C:\Users\moody\.codex\AGENTS.md'=$true;'C:\Users\moody\.codex\config.toml'=$true;
        'C:\AIOS_GITHUB\LOGOS\.codex\config.toml'=$true;'C:\AIOS_GITHUB\LOGOS\AGENTS.md'=$true}
    $roots=@('C:\Users\moody\.codex','C:\','C:\AIOS_GITHUB','C:\AIOS_GITHUB\LOGOS',
        'C:\AIOS_GITHUB\LOGOS\98_SISTEMA_TECNICO',
        'C:\AIOS_GITHUB\LOGOS\tools','C:\AIOS_GITHUB\LOGOS\tools\codex')
    foreach($root in $roots){foreach($name in @('AGENTS.md','AGENTS.override.md')){
        $path=Join-Path $root $name;if(-not $expected.ContainsKey($path)){$expected[$path]=$false}
    }}
    $expected['C:\.codex\config.toml']=$false
    $expected['C:\AIOS_GITHUB\.codex\config.toml']=$false
    if($Policy.instruction_files.Count -ne $expected.Count){throw 'STOP: complete production instruction set required.'}
    $seen=@{}
    foreach($record in $Policy.instruction_files){
        if($seen.ContainsKey($record.path) -or -not $expected.ContainsKey($record.path) -or
            $record.exists -ne $expected[$record.path]){throw 'STOP: production instruction presence/scope mismatch.'}
        $seen[$record.path]=$true
        if($record.path -ceq 'C:\Users\moody\.codex\config.toml'){
            if(-not $record.ContainsKey('guard') -or $record.guard -cne 'codex-operational-v3'){throw 'STOP: user config semantic guard required.'}
        }elseif($record.ContainsKey('guard')){throw 'STOP: semantic guard on foreign instruction file.'}
        if($record.path -ceq 'C:\Users\moody\.codex\AGENTS.md' -and
            $record.sha256 -cne 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'){
            throw 'STOP: global AGENTS changed; review the specific instruction delta.'
        }
    }
}
function Read-AIOSGuardScalar {
    param([string]$Raw)
    # Deliberately bounded TOML subset. Unsupported syntax stops rather than
    # guessing permissions. No regex deletion of arbitrary configuration lines.
    $m=[regex]::Match($Raw,'^"((?:[^"\\]|\\["\\])*)"(?:\s*#.*)?$')
    if($m.Success){return $m.Groups[1].Value.Replace('\"','"').Replace('\\','\')}
    $m=[regex]::Match($Raw,"^'([^']*)'(?:\s*#.*)?$")
    if($m.Success){return $m.Groups[1].Value}
    $m=[regex]::Match($Raw,'^(true|false|0|[1-9][0-9]*)(?:\s*#.*)?$')
    if($m.Success){return $m.Groups[1].Value}
    throw 'STOP: unsupported configuration scalar syntax; acquire the specific config delta.'
}
function Read-AIOSGuardStringArray {
    param([string]$Raw)
    $token='(?:"(?:[^"\\]|\\["\\])*"|''[^'']*'')'
    $pattern='^\[\s*(?:'+$token+'\s*(?:,\s*'+$token+'\s*)*,?\s*)?\](?:\s*#.*)?$'
    if($Raw.Length -gt 16384 -or $Raw -cnotmatch $pattern){throw 'STOP: unsupported configuration string array syntax.'}
    $prefix=[regex]::Match($Raw,('^\[\s*(?:'+$token+'\s*(?:,\s*'+$token+'\s*)*,?\s*)?\]')).Value
    $values=@([regex]::Matches($prefix,$token) | ForEach-Object {Read-AIOSGuardScalar $_.Value})
    if($values.Count -gt 128){throw 'STOP: configuration array cardinality limit.'}
    return ,([object[]]$values)
}
function Get-AIOSAcquiredUserIntegrationPins {
    # Exact acquired configuration values; not an external-tools qualification.
    return @{
        'ROOT|notify'=@{shape='ARRAY';sha256='9bdca3b22011bf07c128913fddc054a03ef497a1486ee53c7d5b7f43383df930'}
        'marketplaces.openai-bundled|source_type'=@{shape='BASIC_STRING';sha256='ea17e25c6c7aa6ef9407f976a670e87e37bc7e2a86b7bd4a3305bb16f1ba6052'}
        'marketplaces.openai-bundled|source'=@{shape='LITERAL_STRING';sha256='4aaea7a0519c336da2f43d1098a65db00a98e432b33b0374495f6219362d96e6'}
        'marketplaces.openai-primary-runtime|source_type'=@{shape='BASIC_STRING';sha256='ea17e25c6c7aa6ef9407f976a670e87e37bc7e2a86b7bd4a3305bb16f1ba6052'}
        'marketplaces.openai-primary-runtime|source'=@{shape='LITERAL_STRING';sha256='c86fbefb903d32f6d3d10a4cf2911999ef7d334fde605121322883380351c514'}
        'plugins.codex-app-tools@openai-bundled|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.browser@openai-bundled|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.unified-computer-use@openai-bundled|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.visualize@openai-bundled|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.computer-use@openai-bundled|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.documents@openai-primary-runtime|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.pdf@openai-primary-runtime|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.spreadsheets@openai-primary-runtime|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.presentations@openai-primary-runtime|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'plugins.template-creator@openai-primary-runtime|enabled'=@{shape='BOOLEAN';sha256='b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b'}
        'mcp_servers.node_repl|args'=@{shape='ARRAY';sha256='4f53cda18c2baa0c0354bb5f9a3ecbe5ed12ab4d8e11ba873c2f11161202b945'}
        'mcp_servers.node_repl|command'=@{shape='LITERAL_STRING';sha256='0f20ae15868baff14ae83be1f3f56dd69041184596d5a473964cc5d75b529437'}
        'mcp_servers.node_repl|env_vars'=@{shape='ARRAY';sha256='55b005debe5c799eab33d781831bab2dd93dedef0928942edf74ccc216fb1ae6'}
        'mcp_servers.node_repl|startup_timeout_sec'=@{shape='NUMBER_OR_DATETIME';sha256='2abaca4911e68fa9bfbf3482ee797fd5b9045b841fdff7253557c5fe15de6477'}
        'mcp_servers.node_repl.env|NODE_REPL_NATIVE_PIPE_CONNECT_TIMEOUT_MS'=@{shape='BASIC_STRING';sha256='ea33dc847d962e75874bfed11cf65b69acebbfa3cabec313effeb7c8b4fc90e1'}
        'mcp_servers.node_repl.env|NODE_REPL_NODE_MODULE_DIRS'=@{shape='LITERAL_STRING';sha256='155adc5bded7539527721aa480d6158d68d915bfc2b1b7863b5930ff1153a335'}
        'mcp_servers.node_repl.env|NODE_REPL_NODE_PATH'=@{shape='LITERAL_STRING';sha256='4e7daa2a8895c35989712b44072e29f497bef9e6ac3d3b8370465caa5cfca0c3'}
        'mcp_servers.node_repl.env|NODE_REPL_TRUSTED_CODE_PATHS'=@{shape='LITERAL_STRING';sha256='7c89cac317fe16b7c34212622fac6a0a4bcdbfd6cf1bb5767a07c57174f46e37'}
        'mcp_servers.node_repl.env|CODEX_HOME'=@{shape='LITERAL_STRING';sha256='bcc817a6735f01afe38402de5c0b98d22440b1fb3d7fb5897db2b4f8c9b5b4e9'}
        'mcp_servers.node_repl.env|BROWSER_USE_AVAILABLE_BACKENDS'=@{shape='BASIC_STRING';sha256='2fea4f146c18a05750abc6315e6d483d83c0bf2586f78ddd2af8ee2977db6251'}
        'mcp_servers.node_repl.env|BROWSER_USE_TINYSKY_ENABLED'=@{shape='BASIC_STRING';sha256='391552c099c101b131feaf24c5795a6a15bc8ec82015424e0d2b4274a369a0bf'}
        'mcp_servers.node_repl.env|NODE_REPL_INSTRUCTIONS_USE_CASE_BROWSER'=@{shape='BASIC_STRING';sha256='12ae32cb1ec02d01eda3581b127c1fee3b0dc53572ed6baf239721a03d82e126'}
        'mcp_servers.node_repl.env|NODE_REPL_INSTRUCTIONS_USE_CASE_CHROME'=@{shape='BASIC_STRING';sha256='12ae32cb1ec02d01eda3581b127c1fee3b0dc53572ed6baf239721a03d82e126'}
        'mcp_servers.node_repl.env|BROWSER_USE_CODEX_APP_BUILD_FLAVOR'=@{shape='BASIC_STRING';sha256='4120bf0e89c30b878b5d1830d3e31493080be0f6dfd295deceacea83cd4dbb50'}
        'mcp_servers.node_repl.env|BROWSER_USE_CODEX_APP_VERSION'=@{shape='BASIC_STRING';sha256='80cfaf76a920d380d325b404658ae3e2b4dddddd37b762f9b63eafad62c0a8fe'}
        'mcp_servers.node_repl.env|NODE_REPL_TRUSTED_SERVICES'=@{shape='LITERAL_STRING';sha256='b38421877c806836ab6142314d86164e1c390a3aad9c5d747823038edca2e198'}
        'mcp_servers.node_repl.env|SKY_CUA_NATIVE_PIPE'=@{shape='BASIC_STRING';sha256='391552c099c101b131feaf24c5795a6a15bc8ec82015424e0d2b4274a369a0bf'}
        'mcp_servers.node_repl.env|SKY_CUA_NATIVE_PIPE_DIRECTORY'=@{shape='LITERAL_STRING';rule='WINDOWS_PIPE_GUID_V1';value_chars=64;masked_sha256='0b8211e26377257fe69d2779525c245b665623125fb755778bb4c9afcc1c145a'}
        'mcp_servers.node_repl.env|CODEX_CLI_PATH'=@{shape='LITERAL_STRING';sha256='f559fb15192d5b48216bf8985d3e5139921d9a3f0290ddf9f6fd505575335634'}
        'mcp_servers.node_repl.env|NODE_REPL_UNTRUSTED_ENV_ALLOWLIST'=@{shape='BASIC_STRING';sha256='063536721e246e5341b782390d4e7c19856a7317de824c0ca17df4b03f305fc5'}
    }
}
function Assert-AIOSAcquiredPipeValue {
    param([string]$Raw,[object]$Rule)
    # Lexical check only. Never resolve, probe, connect or enumerate the pipe.
    # Rule is compiled by the file caller; alternate anchors are a pure test seam.
    if($Rule.rule -cne 'WINDOWS_PIPE_GUID_V1' -or $Rule.shape -cne 'LITERAL_STRING' -or
        $Rule.value_chars -ne 64 -or $Rule.masked_sha256 -cnotmatch '^[0-9a-f]{64}$'){
        throw 'STOP: acquired pipe rule mismatch.'
    }
    $literal=[regex]::Match($Raw,'^''([^'']*)''$')
    if(-not $literal.Success){throw 'STOP: acquired pipe literal syntax changed.'}
    $value=$literal.Groups[1].Value
    if($value.Length -ne $Rule.value_chars -or -not $value.StartsWith('\\.\pipe\',[StringComparison]::Ordinal) -or
        $value.Contains('/') -or [regex]::IsMatch($value,'[\x00-\x1f\x7f]')){
        throw 'STOP: acquired pipe structure changed.'
    }
    $parts=@($value.Split([char]92))
    if($parts.Count -ne 5 -or $parts[0] -cne '' -or $parts[1] -cne '' -or
        $parts[2] -cne '.' -or $parts[3] -cne 'pipe' -or $parts[4] -ceq '..'){
        throw 'STOP: acquired pipe structure changed.'
    }
    $pattern='(?i)(?<![0-9a-f])(?:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|[0-9a-f]{32})(?![0-9a-f])'
    $guidMatches=[regex]::Matches($value,$pattern)
    if($guidMatches.Count -ne 1 -or $guidMatches[0].Index -lt 9){throw 'STOP: acquired pipe GUID cardinality changed.'}
    $masked=[regex]::Replace($value,$pattern,'<GUID>')
    if((Get-AIOSHash ((New-Object Text.UTF8Encoding($false)).GetBytes($masked))) -cne $Rule.masked_sha256){
        throw 'STOP: acquired pipe fixed structure changed; review the specific delta.'
    }
}
function Assert-AIOSCodexConfigText {
    param([string]$Text,[string]$Root,[ValidateSet('User','Project')][string]$Role,
        [object]$IntegrationPins,[bool]$RequireIntegrationSet=$false)
    # A pure validator seam for component tests. File-based production callers
    # below always supply the compiled acquisition pins and required real set.
    $section='';$project='';$seen=@{};$tables=@{};$operational=@{};$trust='';$windows=''
    $profileDescription='';$profileExtends='';$integrationSeen=@{}
    foreach($line in @($Text -split "`n")){
        $line=$line.Trim()
        if($line -ceq '' -or $line.StartsWith('#')){continue}
        if($line.StartsWith('[')){
            $m=[regex]::Match($line,'^\[([^\]]+)\](?:\s*#.*)?$')
            if(-not $m.Success){throw 'STOP: unsupported configuration table syntax.'}
            $header=$m.Groups[1].Value.Trim();$project=''
            if($Role -ceq 'Project' -and $header -ceq 'permissions.logos_readonly'){$section=$header}
            elseif(@('windows','tui','tui.model_availability_nux') -ccontains $header){$section=$header}
            elseif($header.StartsWith('projects.',[StringComparison]::Ordinal)){
                $project=Read-AIOSGuardScalar $header.Substring(9);$section='projects'
                if($project -cnotmatch '^[A-Za-z]:\\' -or $project -match '[\x00-\x1f]'){throw 'STOP: invalid configuration project path.'}
            }elseif($Role -ceq 'User'){
                $section=$header
                if($header.StartsWith('plugins.',[StringComparison]::Ordinal)){
                    $section='plugins.'+(Read-AIOSGuardScalar $header.Substring(8))
                }
                $registered=@($IntegrationPins.Keys | Where-Object {$_.StartsWith($section+'|',[StringComparison]::Ordinal)})
                if($section -cne 'desktop' -and $registered.Count -eq 0){throw 'STOP: configuration table requires targeted review.'}
            }else{throw 'STOP: configuration table requires targeted review.'}
            $tableIdentity=$section
            if($section -ceq 'projects'){$tableIdentity+='|'+$project.ToUpperInvariant()}
            if($tables.ContainsKey($tableIdentity)){throw 'STOP: duplicate configuration table.'};$tables[$tableIdentity]=$true
            continue
        }
        $m=[regex]::Match($line,"^([A-Za-z0-9_-]+|`"(?:[^`"\\]|\\[`"\\])*`"|'[^']*')\s*=\s*(.+)$")
        if(-not $m.Success){throw 'STOP: unsupported configuration assignment.'}
        $key=$m.Groups[1].Value
        if($key.StartsWith('"') -or $key.StartsWith("'")){$key=Read-AIOSGuardScalar $key}
        $raw=$m.Groups[2].Value.Trim()
        $identity=$section+'|'+$project+'|'+$key
        if($seen.ContainsKey($identity)){throw 'STOP: duplicate configuration key.'};$seen[$identity]=$true
        $integrationId=$(if($section -ceq ''){'ROOT|'+$key}else{$section+'|'+$key})
        if($Role -ceq 'User' -and @($IntegrationPins.Keys) -ccontains $integrationId){
            $pin=$IntegrationPins[$integrationId]
            if($pin.ContainsKey('rule')){
                if($integrationId -cne 'mcp_servers.node_repl.env|SKY_CUA_NATIVE_PIPE_DIRECTORY'){
                    throw 'STOP: structural rule on foreign integration field.'
                }
                Assert-AIOSAcquiredPipeValue $raw $pin
            }else{
                if((Get-AIOSHash ((New-Object Text.UTF8Encoding($false)).GetBytes($raw))) -cne $pin.sha256){
                    throw 'STOP: acquired integration config changed; review the specific delta.'
                }
                if($pin.shape -ceq 'ARRAY'){$unusedArray=Read-AIOSGuardStringArray $raw}
                else{$unusedScalar=Read-AIOSGuardScalar $raw}
            }
            $integrationSeen[$integrationId]=$true
            continue
        }
        $value=Read-AIOSGuardScalar $raw
        if($section -ceq ''){
            if($key -ceq 'default_permissions' -and $Role -ceq 'Project'){$operational[$key]=$value}
            elseif(@('sandbox_mode','approval_policy','approvals_reviewer') -ccontains $key){$operational[$key]=$value}
            elseif($key -ceq 'service_tier'){
                if($Role -cne 'User' -or $value -cne 'priority'){throw 'STOP: service_tier requires targeted review; only the acquired User priority value is supported.'}
            }
            elseif(@('model','model_reasoning_effort','model_verbosity','personality') -cnotcontains $key){throw 'STOP: configuration key requires targeted review.'}
        }elseif($section -ceq 'permissions.logos_readonly'){
            if($key -ceq 'description'){$profileDescription=$value}
            elseif($key -ceq 'extends'){$profileExtends=$value}
            else{throw 'STOP: profile key requires targeted review.'}
        }elseif($section -ceq 'windows'){
            if($key -cne 'sandbox' -or $value -cne 'elevated'){throw 'STOP: Windows sandbox differs from the acquired operational profile.'};$windows=$value
        }elseif($section -ceq 'projects'){
            if($key -cne 'trust_level' -or @('trusted','untrusted') -cnotcontains $value){throw 'STOP: unsupported project configuration.'}
            if($project -ieq $Root){if($trust -cne ''){throw 'STOP: duplicate current-root trust table.'};$trust=$value}
        }elseif($section -ceq 'tui'){
            if(@('screen_reader_detection_done','animations','alternate_screen') -cnotcontains $key){throw 'STOP: TUI key requires targeted review.'}
        }elseif($section -ceq 'tui.model_availability_nux'){
            if($value -cnotmatch '^(0|[1-9][0-9]*)$'){throw 'STOP: invalid model availability preference.'}
        }elseif($section -ceq 'desktop'){
            if($key -ceq 'followUpQueueMode' -and $value -ceq 'steer'){}
            elseif($key -ceq 'conversationDetailMode' -and $value -ceq 'STEPS_PROSE'){}
            elseif(@('sansFontSize','codeFontSize') -ccontains $key -and $value -cmatch '^(0|[1-9][0-9]*)$' -and [long]$value -ge 8 -and [long]$value -le 72){}
            elseif($key -ceq 'ambient-suggestions-enabled' -and @('true','false') -ccontains $value){}
            else{throw 'STOP: Desktop preference requires targeted review.'}
        }else{throw 'STOP: integration configuration key requires targeted review.'}
    }
    if($Role -ceq 'User' -and ($RequireIntegrationSet -or $integrationSeen.Count -gt 0)){
        if($integrationSeen.Count -ne $IntegrationPins.Count){throw 'STOP: acquired integration config set incomplete.'}
        foreach($name in $IntegrationPins.Keys){if(-not $integrationSeen.ContainsKey($name)){throw 'STOP: acquired integration config set incomplete.'}}
    }
    $named=($Role -ceq 'Project' -and $operational.ContainsKey('default_permissions'))
    if($named -and $operational.ContainsKey('sandbox_mode')){throw 'STOP: permission profile cannot be combined with sandbox_mode.'}
    $required=@{approval_policy='on-request';approvals_reviewer='user'}
    if(-not $named){$required['sandbox_mode']='read-only'}
    foreach($key in $required.Keys){
        if(($Role -ceq 'Project' -and -not $operational.ContainsKey($key)) -or
            ($operational.ContainsKey($key) -and $operational[$key] -cne $required[$key])){throw 'STOP: incompatible Codex operational setting.'}
    }
    if($Role -ceq 'Project'){
        if($named){
            if($operational['default_permissions'] -cne 'logos_readonly' -or $tables.Count -ne 1 -or
                -not $tables.ContainsKey('permissions.logos_readonly') -or $profileExtends -cne ':read-only' -or
                $profileDescription -cne 'LOGOS - read-only with human approvals'){throw 'STOP: approved project permission profile mismatch.'}
        }elseif($tables.Count -ne 0){throw 'STOP: project configuration tables need a separately reviewed profile.'}
    }elseif($trust -cne 'trusted' -or $windows -cne 'elevated'){throw 'STOP: current-root trust/Windows sandbox differs from the acquired operational profile.'}
}
function Assert-AIOSCodexSemanticConfig {
    param([string]$Path,[string]$Root,[ValidateSet('User','Project')][string]$Role)
    Assert-AIOSExistingFile $Path
    $bytes=[IO.File]::ReadAllBytes($Path)
    if($bytes.Length -gt 131072){throw 'STOP: configuration size limit.'}
    $text=(New-Object Text.UTF8Encoding($false,$true)).GetString($bytes).TrimStart([char]0xfeff)
    $pins=Get-AIOSAcquiredUserIntegrationPins
    $requireSet=($Role -ceq 'User' -and $Path -ieq 'C:\Users\moody\.codex\config.toml')
    Assert-AIOSCodexConfigText $text $Root $Role $pins $requireSet
    # This checks file semantics/preservation, not GUI overrides, external
    # commands, plugin binaries, MCP server behavior or effective permissions.
}

function Resolve-AIOSBaselinePath {
    param([string]$Root,[string]$Relative)
    if([string]::IsNullOrWhiteSpace($Relative) -or $Relative.Length -gt 240 -or
        $Relative -match '^[\/]|[\\:\x00-\x1f<>"|?*]'){throw 'STOP: unsafe baseline path.'}
    $current=$Root
    foreach($part in $Relative.Split('/')){
        if($part -in @('', '.', '..') -or $part.EndsWith('.') -or $part.EndsWith(' ') -or $part -ieq '.git' -or
            $part -match '^(?i:CON|PRN|AUX|NUL|COM[0-9]|LPT[0-9])(?:\.|$)'){throw 'STOP: ambiguous baseline path.'}
        Assert-AIOSPlainDirectory $current
        $matches=@((New-Object IO.DirectoryInfo($current)).GetFileSystemInfos() | Where-Object {$_.Name -ieq $part})
        if($matches.Count -ne 1 -or $matches[0].Name -cne $part -or ($matches[0].Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0){throw 'STOP: baseline path spelling/link mismatch.'}
        $current=Join-Path $current $part
    }
    Assert-AIOSExistingFile $current
    return $current
}
function Read-AIOSEntrypointBaseline {
    param([string]$Path,[string]$Hash,[string]$Root,[string]$RecoveryRoot,[object]$Handoff,[bool]$AllowTargetPost=$false)
    Assert-AIOSEntrypointRoot $Root $RecoveryRoot
    Assert-AIOSEntrypointExternal $Root $Path;Assert-AIOSPinnedEvidence $Path $Hash
    if($Path -cne (Join-Path ([IO.Path]::GetDirectoryName($RecoveryRoot)) 'baseline.json')){throw 'STOP: baseline location mismatch.'}
    $b=Read-AIOSCanonicalJson $Path
    Assert-AIOSFields $b @('format','root','branch','head','source_capture_sha256','index_sha256','files')
    if($b.format -cne 'AIOS-DOCUMENT-BASELINE/2.0' -or $b.root -cne $Root -or $b.branch -cne $Handoff.repository.branch -or
        $b.head -cne $Handoff.repository.expected_head -or $b.source_capture_sha256 -cnotmatch '^[0-9a-f]{64}$' -or
        $b.index_sha256 -cnotmatch '^[0-9a-f]{64}$' -or $b.files -isnot [array] -or $b.files.Count -gt 128){throw 'STOP: baseline identity/cardinality mismatch.'}
    $seen=@{}
    foreach($file in $b.files){
        Assert-AIOSFields $file @('path','status','sha256')
        if($file.path -isnot [string] -or $seen.ContainsKey($file.path) -or @(' M','??') -cnotcontains $file.status -or
            $file.sha256 -cnotmatch '^[0-9a-f]{64}$'){throw 'STOP: baseline path/status/hash mismatch; staging, rename and deletion excluded.'}
        $seen[$file.path]=$file
        [void](Resolve-AIOSBaselinePath $Root $file.path)
    }
    $target=$Handoff.files[0]
    if($target.path -cne $script:AIOSDocumentTarget){throw 'STOP: baseline target mismatch.'}
    $script:AIOSBaselineTargetStatus=''
    if($seen.ContainsKey($target.path)){
        if($seen[$target.path].path -cne $target.path -or $seen[$target.path].status -cne ' M' -or
            $seen[$target.path].sha256 -cne $target.pre_sha256){throw 'STOP: target baseline preimage mismatch.'}
        $script:AIOSBaselineTargetStatus=' M'
    }
    # A clean target is absent from dirty records but must already be tracked.
    $tracked=Read-AIOSGit $Root @('ls-files','--error-unmatch','--',$target.path)
    if($tracked.Count -ne 1 -or $tracked[0] -cne $target.path){throw 'STOP: an existing tracked target is required.'}
    # Runtime/config may be clean after a commit. Their protection is independent
    # of dirty status: entrypoint pins + activation receipt + repeated hash guard.
    foreach($name in $script:AIOSInstalledNames){
        $rel='tools/codex/'+$name
        if($seen.ContainsKey($rel) -and ($seen[$rel].path -cne $rel -or $seen[$rel].sha256 -cne $script:AIOSLoadedRuntimePins[$name])){
            throw 'STOP: installed runtime dirty snapshot mismatch.'
        }
    }
    $script:AIOSBaseline=$b;$script:AIOSBaselinePath=$Path;$script:AIOSBaselineHash=$Hash;$script:AIOSBaselineTarget=$target
    Assert-AIOSBaselineState $Root @() $AllowTargetPost
}
function Assert-AIOSBaselineState {
    param([string]$Root,[string[]]$AppliedPaths=@(),[bool]$AllowTargetPost=$false)
    if($null -eq $script:AIOSBaseline -or $script:AIOSBaseline.root -cne $Root){throw 'STOP: pinned baseline required.'}
    Assert-AIOSPinnedEvidence $script:AIOSBaselinePath $script:AIOSBaselineHash
    if((Get-AIOSHash (ConvertTo-AIOSBytes ([AIOSHandoff.StrictJson]::Canonical($script:AIOSBaseline)))) -cne $script:AIOSBaselineHash){throw 'STOP: in-memory baseline changed.'}
    if($AppliedPaths.Count -gt 1 -or @($AppliedPaths | Where-Object {$_ -cne $script:AIOSDocumentTarget}).Count -ne 0){throw 'STOP: foreign applied baseline exception.'}
    foreach($name in $script:AIOSInstalledNames){Assert-AIOSPinnedEvidence (Join-Path $PSScriptRoot $name) $script:AIOSLoadedRuntimePins[$name]}
    $targetPath=Resolve-AIOSDocumentPath $Root $script:AIOSDocumentTarget
    $targetHash=Get-AIOSHash ([IO.File]::ReadAllBytes($targetPath))
    $expectedTarget=$(if($AppliedPaths -ccontains $script:AIOSDocumentTarget){$script:AIOSBaselineTarget.post_sha256}else{$script:AIOSBaselineTarget.pre_sha256})
    if($targetHash -cne $expectedTarget -and -not ($AllowTargetPost -and $targetHash -ceq $script:AIOSBaselineTarget.post_sha256)){
        throw 'STOP: baseline target phase/hash mismatch.'
    }
    foreach($file in $script:AIOSBaseline.files){
        $path=Resolve-AIOSBaselinePath $Root $file.path;$hash=Get-AIOSHash ([IO.File]::ReadAllBytes($path))
        $expected=$file.sha256
        if($AppliedPaths -ccontains $file.path){$expected=$script:AIOSBaselineTarget.post_sha256}
        if($hash -cne $expected -and -not ($AllowTargetPost -and $file.path -ceq $script:AIOSDocumentTarget -and $hash -ceq $script:AIOSBaselineTarget.post_sha256)){
            throw ('STOP: protected baseline file changed: '+$file.path)
        }
    }
}
function Assert-AIOSGitIdentity {
    param([object]$Context)
    & $script:AIOSOriginalGitIdentity $Context
    # Both IDs remain exact transaction pins. An unpushed manual commit is
    # allowed only when the acquired upstream is an ancestor of local HEAD.
    if($Context.Handoff.repository.expected_head -cne $Context.Handoff.repository.expected_upstream_sha){
        [void](Read-AIOSGit $Context.Root @('merge-base','--is-ancestor',
            $Context.Handoff.repository.expected_upstream_sha,$Context.Handoff.repository.expected_head))
    }
}
function Get-AIOSDocumentTargetStatus {
    param([string]$Root)
    $rows=Read-AIOSGit $Root @('status','--porcelain=v1','--untracked-files=all','--',$script:AIOSDocumentTarget)
    if($rows.Count -eq 0){return ''}
    if($rows.Count -ne 1 -or $rows[0] -cne (' M '+$script:AIOSDocumentTarget)){throw 'STOP: staged/untracked/renamed/deleted target excluded.'}
    return ' M'
}
function Assert-AIOSStatus {
    param([string]$Root,[string[]]$Expected,[string[]]$AppliedPaths=@())
    Assert-AIOSBaselineState $Root $AppliedPaths
    foreach($row in $Expected){if($row -cne (' M '+$script:AIOSDocumentTarget)){throw 'STOP: foreign document status exception.'}}
    $targetStatus=Get-AIOSDocumentTargetStatus $Root
    if($AppliedPaths -cnotcontains $script:AIOSDocumentTarget -and $targetStatus -cne $script:AIOSBaselineTargetStatus){
        throw 'STOP: target initial status changed.'
    }
    # Postimage hash and immutable index prove the only permissible transition.
    # A change that restores index content can legitimately become clean.
    $baseline=@($script:AIOSBaseline.files | Where-Object {$_.path -cne $script:AIOSDocumentTarget} | ForEach-Object {$_.status+' '+$_.path})
    if($targetStatus -cne ''){$baseline+=($targetStatus+' '+$script:AIOSDocumentTarget)}
    & $script:AIOSOriginalStatus $Root ([string[]]$baseline)
}
function Save-AIOSNextBaselineCandidate {
    param([object]$Durable,[string]$JournalPath,[string]$JournalHash)
    $c=$Durable.Context;$d=$Durable.Descriptor
    $mutex=New-Object Threading.Mutex($false,('Local\AIOS_DOCUMENT_TRANSACTION_'+(Get-AIOSHash (ConvertTo-AIOSBytes $c.Root.ToLowerInvariant()))))
    $owned=$false
    try{
        $owned=$mutex.WaitOne(0);if(-not $owned){throw 'STOP: another transaction owns this root.'}
        [void](Read-AIOSAppliedRecovery $Durable $JournalPath $JournalHash)
        $b=[AIOSHandoff.StrictJson]::Parse([AIOSHandoff.StrictJson]::Canonical($script:AIOSBaseline))
        $b.files=@($b.files | Where-Object {$_.path -cne $script:AIOSDocumentTarget})
        $status=Get-AIOSDocumentTargetStatus $c.Root
        if($status -cne ''){$b.files+=@{path=$script:AIOSDocumentTarget;status=$status;sha256=$c.Handoff.files[0].post_sha256}}
        # Keep candidates inside this run's pinned recovery, beside transactions.
        # Nesting beneath transaction_<UUID> exceeds legacy Windows path limits.
        $candidateParent=$d.recovery_root;Assert-AIOSPlainDirectory $candidateParent
        $directory=Join-Path $candidateParent ('next_baseline_'+[Guid]::NewGuid().ToString('N'))
        $path=Join-Path $directory 'baseline.candidate.json'
        if($directory.Length -ge 248 -or $path.Length -ge 260){throw 'STOP: next baseline path exceeds Windows PowerShell 5.1 path budget.'}
        if(Test-Path -LiteralPath $directory){throw 'STOP: next baseline identity already exists; no reuse.'}
        [void][IO.Directory]::CreateDirectory($directory);Assert-AIOSPlainDirectory $directory
        Write-AIOSNewBytes $path (ConvertTo-AIOSBytes (ConvertTo-AIOSCanonicalJson $b))
        $hash=Get-AIOSHash ([IO.File]::ReadAllBytes($path))
        $receipt=[ordered]@{format='AIOS-NEXT-BASELINE-CANDIDATE/1.0';status='REVIEW_REQUIRED';adopted=$false;
            baseline_path=$path;baseline_sha256=$hash;previous_baseline_sha256=$script:AIOSBaselineHash;
            descriptor_sha256=$Durable.Hash;journal_path=$JournalPath;journal_sha256=$JournalHash;handoff_sha256=$c.HandoffHash}
        $receiptPath=Join-Path $directory 'receipt.json'
        Write-AIOSNewBytes $receiptPath (ConvertTo-AIOSBytes (ConvertTo-AIOSCanonicalJson $receipt))
        # Return success only if the fully bound state still matches. On STOP,
        # any external candidate remains unadopted and is not a usable receipt.
        [void](Read-AIOSAppliedRecovery $Durable $JournalPath $JournalHash)
        return [pscustomobject]@{path=$path;sha256=$hash;receipt_path=$receiptPath;
            receipt_sha256=Get-AIOSHash ([IO.File]::ReadAllBytes($receiptPath));adopted=$false;status='REVIEW_REQUIRED'}
    }finally{if($owned){$mutex.ReleaseMutex()};$mutex.Dispose()}
}

function Read-AIOSFixtureApproval {
    param([object]$Context,[string]$Path,[string]$ExpectedSha256,[string]$Action,[string]$EvidencePath,[string]$EvidenceHash)
    if($script:AIOSExecutionScope -ceq 'LOGOSDocument'){Assert-AIOSApprovedBridgeLease $Context $Action}
    Assert-AIOSEntrypointExternal $Context.Root $Path;Assert-AIOSPinnedEvidence $Path $ExpectedSha256
    $a=Read-AIOSCanonicalJson $Path
    $fields=@('format','scope','action','root','handoff_sha256','policy_sha256','profile_sha256','check_executor_sha256',
        'transaction_module_sha256','evidence_path','evidence_sha256','entrypoint_sha256','adapter_sha256','descriptor_sha256','baseline_sha256')
    $real=$script:AIOSExecutionScope -ceq 'LOGOSDocument'
    if($real){$fields+=@('request_sha256','decision_sha256','reservation_sha256','wrapper_sha256','command_plan_sha256')}
    Assert-AIOSFields $a $fields
    foreach($key in $a.Keys){if($a[$key] -isnot [string]){throw 'STOP: approval string fields required.'}}
    $format=$(if($real){'AIOS-DOCUMENT-BRIDGE-AUTHORIZATION/1.0'}else{'AIOS-ENTRYPOINT-TEST-APPROVAL/2.1'})
    $scope=$(if($real){'LOGOS_DOCUMENT_RANGES_ONLY'}else{'ISOLATED_TEST_ONLY'})
    if($a.format -cne $format -or $a.scope -cne $scope -or $a.action -cne $Action -or $a.root -cne $Context.Root -or
        $a.handoff_sha256 -cne $Context.HandoffHash -or $a.policy_sha256 -cne $Context.Handoff.policy_sha256 -or
        $a.profile_sha256 -cne $Context.Handoff.project_profile.profile_sha256 -or $a.check_executor_sha256 -cne $Context.Handoff.executor_sha256 -or
        $a.transaction_module_sha256 -cne (Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOStransactionModulePath))) -or
        $a.evidence_path -cne [IO.Path]::GetFullPath($EvidencePath) -or $a.evidence_sha256 -cne $EvidenceHash -or
        $a.entrypoint_sha256 -cne $Context.Handoff.executor_sha256 -or
        $a.adapter_sha256 -cne (Get-AIOSHash ([IO.File]::ReadAllBytes($script:AIOSProductionAdapterPath))) -or
        $a.descriptor_sha256 -cne $script:AIOSActiveDescriptorHash -or $a.baseline_sha256 -cne $script:AIOSBaselineHash){
        throw 'STOP: R2 approval binding mismatch.'
    }
    if($real){
        $lease=$script:AIOSApprovedBridgeLease
        if($Path -cne (Join-Path ([IO.Path]::GetDirectoryName($lease.request_path)) 'engine_approval.json')){throw 'STOP: bridge authorization location mismatch.'}
        foreach($key in @('request_sha256','decision_sha256','reservation_sha256','wrapper_sha256','command_plan_sha256')){
            if($a[$key] -cne $lease.$key){throw 'STOP: bridge authorization detached from reserved decision.'}
        }
    }
    return ,$a
}

function Initialize-AIOSReleaseActivation {
    param([string]$Path,[string]$Hash)
    $script:AIOSReleaseActivation=$null
    if($PSScriptRoot -cne 'C:\AIOS_GITHUB\LOGOS\tools\codex'){throw 'STOP: production module must be installed.'}
    $prefix='C:\AIOS_MIGRAZIONE\LOGOS_R22_RELEASE_SETUP'
    if($Hash -cnotmatch '^[0-9a-f]{64}$' -or -not $Path.StartsWith($prefix+'\',[StringComparison]::Ordinal) -or
        $Path.Substring($prefix.Length+1) -cnotmatch '^[0-9a-f]{32}\\setup_receipt\.json$'){throw 'STOP: pinned verified setup receipt required.'}
    Assert-AIOSPinnedEvidence $Path $Hash
    $r=Read-AIOSCanonicalJson $Path
    if($r.format -cne 'LOGOS-R22-SETUP-RECEIPT/1.0' -or $r.state -cne 'VERIFIED' -or $r.root -cne 'C:\AIOS_GITHUB\LOGOS' -or
        $r.scope -cne 'LOGOS_RELEASE_SETUP_ONLY' -or $r.files -isnot [array] -or $r.files.Count -ne $script:AIOSInstalledNames.Count){throw 'STOP: verified setup receipt identity mismatch.'}
    $seen=@{}
    foreach($f in $r.files){
        Assert-AIOSFields $f @('name','installed_sha256')
        if($f.name -isnot [string] -or $script:AIOSInstalledNames -cnotcontains $f.name -or $seen.ContainsKey($f.name) -or $f.installed_sha256 -cnotmatch '^[0-9a-f]{64}$'){throw 'STOP: verified setup runtime set mismatch.'}
        $seen[$f.name]=$true;Assert-AIOSPinnedEvidence (Join-Path $PSScriptRoot $f.name) $f.installed_sha256
    }
    $script:AIOSReleaseActivation=[pscustomobject]@{path=$Path;sha256=$Hash}
}
function Assert-AIOSApprovedBridgeLease {
    param([object]$Context,[string]$Action)
    if($null -eq $script:AIOSApprovedBridgeLease){throw 'STOP: reserved approved bridge lease required; direct technical approval is disabled.'}
    $l=$script:AIOSApprovedBridgeLease
    if($l.root -cne $Context.Root -or $l.action -cne $Action -or $l.wrapper_path -cne 'C:\AIOS_GITHUB\LOGOS\tools\codex\Invoke-AIOSApprovedAction.ps1' -or
        $script:AIOSRunningEntryPath -cne 'C:\AIOS_GITHUB\LOGOS\tools\codex\Invoke-AIOSDocumentApply.ps1' -or $null -eq $script:AIOSReleaseActivation){throw 'STOP: reserved bridge lease identity mismatch.'}
    foreach($p in $l.pins){Assert-AIOSPinnedEvidence $p.path $p.sha256}
    $v=Read-AIOSApprovalProtocol $Context.Root $l.request_path $l.request_sha256 $l.decision_path $l.decision_sha256 $(if($Action -ceq 'APPLY'){'Apply'}else{'Rollback'})
    if($v.request_id -cne $l.request_id){throw 'STOP: reserved bridge request mismatch.'}
    $claim=Read-AIOSApprovalPinnedJson $l.reservation_path $l.reservation_sha256
    if($claim.state -cne 'RESERVED' -or $claim.request_sha256 -cne $l.request_sha256 -or $claim.decision_sha256 -cne $l.decision_sha256 -or $claim.action.ToUpperInvariant() -cne $Action){throw 'STOP: bridge reservation mismatch.'}
}

# LOGOS initial lane admits no ignored files. P4 exclusions are repository-specific.
function Assert-AIOSIgnoredPaths {
    param([object]$Context)
    & $script:AIOSOriginalIgnoredPaths $Context
}
