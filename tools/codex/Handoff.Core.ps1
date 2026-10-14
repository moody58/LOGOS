# AIOS integrated candidate. Real repositories are CHECK ONLY in this revision.
Set-StrictMode -Version 2.0

function Read-AIOSCanonicalJson {
    param([string]$Path)
    Assert-AIOSExistingFile $Path
    if ((Get-Item -LiteralPath $Path -Force).Length -gt 2097152) { throw 'STOP: JSON file size limit.' }
    return ,([AIOSHandoff.StrictJson]::ParseCanonical([IO.File]::ReadAllBytes($Path)))
}
function ConvertTo-AIOSCanonicalJson {
    param([object]$Value)
    # Used only to serialize objects created by this program, never untrusted input.
    $plain = [AIOSHandoff.StrictJson]::Parse(($Value | ConvertTo-Json -Depth 20 -Compress))
    return [AIOSHandoff.StrictJson]::Canonical($plain)
}
function Write-AIOSNewBytes {
    param([string]$Path, [byte[]]$Bytes)
    $stream = New-Object IO.FileStream($Path, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::None)
    try { $stream.Write($Bytes, 0, $Bytes.Length); $stream.Flush($true) } finally { $stream.Dispose() }
    Assert-AIOSExistingFile $Path
    if ((Get-AIOSHash ([IO.File]::ReadAllBytes($Path))) -cne (Get-AIOSHash $Bytes)) { throw 'STOP: created file verification failed.' }
}
function Assert-AIOSPlainDirectory {
    param([string]$Path)
    $directory = New-Object IO.DirectoryInfo([IO.Path]::GetFullPath($Path))
    while ($null -ne $directory) {
        if (-not $directory.Exists -or ($directory.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'STOP: missing directory or reparse point.' }
        $directory = $directory.Parent
    }
}
function Assert-AIOSStringArray {
    param([object]$Value, [bool]$AllowEmpty = $false)
    if ($Value -isnot [array] -or $Value.Count -gt 128 -or (-not $AllowEmpty -and $Value.Count -eq 0)) { throw 'STOP: bounded string array required.' }
    $seen = @{}
    foreach ($item in $Value) {
        if ($item -isnot [string] -or [string]::IsNullOrWhiteSpace($item) -or $item.Length -gt 512 -or $item -match '[\x00-\x1f]' -or $seen.ContainsKey($item)) { throw 'STOP: invalid or duplicate string array item.' }
        $seen[$item] = $true
    }
}
function Assert-AIOSSourceRelative {
    param([string]$Relative)
    if ([string]::IsNullOrWhiteSpace($Relative) -or $Relative.Length -gt 240 -or $Relative -match '^[\/]|[\\:\x00-\x1f<>"|?*]') { throw 'STOP: unsafe source path.' }
    foreach ($part in $Relative.Split('/')) {
        if ($part -in @('', '.', '..') -or $part.EndsWith('.') -or $part.EndsWith(' ') -or $part -ieq '.git' -or $part -ieq '.codex' -or $part -match '^(?i:CON|PRN|AUX|NUL|COM[0-9]|LPT[0-9])(?:\.|$)') { throw 'STOP: ambiguous or protected source path.' }
    }
}
function Resolve-AIOSSourcePath {
    param([string]$Root, [string]$Relative)
    Assert-AIOSSourceRelative $Relative
    Assert-AIOSPlainDirectory $Root
    $current = $Root
    foreach ($part in $Relative.Split('/')) {
        $matches = @((New-Object IO.DirectoryInfo($current)).GetFileSystemInfos() | Where-Object { $_.Name -ieq $part })
        if ($matches.Count -ne 1 -or $matches[0].Name -cne $part -or ($matches[0].Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'STOP: source path missing, ambiguous or linked.' }
        $current = Join-Path $current $part
    }
    Assert-AIOSExistingFile $current
    return $current
}
function Assert-AIOSProfilePolicy {
    param([object]$Policy, [object]$Profile)
    foreach ($key in @('format', 'stage', 'project', 'repository', 'root', 'branch')) {
        if ($Policy[$key] -isnot [string] -or [string]::IsNullOrWhiteSpace($Policy[$key]) -or $Policy[$key] -match '[\x00-\x1f]') { throw 'STOP: policy string required.' }
    }
    foreach ($key in @('id', 'project', 'repository', 'source_commit')) {
        if ($Profile[$key] -isnot [string] -or [string]::IsNullOrWhiteSpace($Profile[$key])) { throw 'STOP: profile string required.' }
    }
    foreach ($key in @('origin_urls', 'allowed_paths')) { Assert-AIOSStringArray $Policy[$key] }
    Assert-AIOSStringArray $Policy.allowed_new_directories $true
    if ($Policy.expected_status -isnot [array] -or $Policy.expected_status.Count -ne 0) { throw 'STOP: this revision requires a completely clean working copy and index.' }
    foreach ($path in $Policy.allowed_paths) { Assert-AIOSRelativePath $path }
    foreach ($path in $Policy.allowed_new_directories) { Assert-AIOSSourceRelative $path }
    if ($Profile.sources -isnot [array] -or $Profile.sources.Count -lt 1 -or $Profile.sources.Count -gt 64) { throw 'STOP: invalid profile source set.' }
    $seen = @{}
    foreach ($source in $Profile.sources) {
        Assert-AIOSFields $source @('path', 'commit', 'blob_sha1', 'working_sha256')
        Assert-AIOSSourceRelative $source.path
        if ($seen.ContainsKey($source.path)) { throw 'STOP: source path case collision.' }
        $seen[$source.path] = $true
    }
    foreach ($category in @('naming', 'archiving', 'versioning')) {
        Assert-AIOSFields $Profile[$category] @('source_paths', 'decision')
        Assert-AIOSStringArray $Profile[$category].source_paths
        if ($Profile[$category].decision -isnot [string] -or [string]::IsNullOrWhiteSpace($Profile[$category].decision)) { throw 'STOP: profile decision required.' }
        foreach ($path in $Profile[$category].source_paths) { if (-not $seen.ContainsKey($path)) { throw 'STOP: profile reference outside source set.' } }
    }
    if ($Policy.instruction_files -isnot [array] -or $Policy.instruction_files.Count -gt 128) { throw 'STOP: invalid instruction evidence array.' }
    foreach ($evidence in $Policy.instruction_files) {
        if ($evidence.exists -isnot [bool]) { throw 'STOP: evidence boolean required.' }
        $fields = $(if ($evidence.exists) { @('path', 'exists', 'sha256') } else { @('path', 'exists') })
        if ($evidence.ContainsKey('guard')) {
            $fields += 'guard'
            if (-not $evidence.exists -or $evidence.guard -cne 'codex-operational-v4') { throw 'STOP: unsupported semantic instruction guard.' }
        }
        Assert-AIOSFields $evidence $fields
        if ($evidence.path -isnot [string] -or $evidence.path -cnotmatch '^[A-Za-z]:\\' -or $evidence.path -match '[\x00-\x1f]') { throw 'STOP: evidence absolute path required.' }
        if ($evidence.exists -and $evidence.sha256 -cnotmatch '^[0-9a-f]{64}$') { throw 'STOP: evidence hash required.' }
    }
}
function Resolve-AIOSDocumentPath {
    param([string]$Root, [string]$Relative, [bool]$MustExist = $true)
    Assert-AIOSRelativePath $Relative
    Assert-AIOSPlainDirectory $Root
    $current = [IO.Path]::GetFullPath($Root).TrimEnd('\', '/')
    $parts = $Relative.Split('/')
    for ($i = 0; $i -lt $parts.Count; $i++) {
        if ([IO.Directory]::Exists($current)) {
            $matches = @((New-Object IO.DirectoryInfo($current)).GetFileSystemInfos() | Where-Object { $_.Name -ieq $parts[$i] })
            if ($matches.Count -gt 1) { throw 'STOP: path case collision.' }
            if ($matches.Count -eq 1) {
                if ($matches[0].Name -cne $parts[$i]) { throw 'STOP: path spelling/case differs from working copy.' }
                if (($matches[0].Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'STOP: linked path.' }
                if ($i -lt ($parts.Count - 1) -and $matches[0] -isnot [IO.DirectoryInfo]) { throw 'STOP: parent is not a directory.' }
            }
        }
        $current = Join-Path $current $parts[$i]
    }
    if ($MustExist) { Assert-AIOSExistingFile $current }
    elseif (Test-Path -LiteralPath $current) { throw 'STOP: new target already exists.' }
    return $current
}
function Read-AIOSGit {
    param([string]$Root, [string[]]$Arguments, [int[]]$AllowedExitCodes = @(0), [string[]]$CommandConfiguration = @())
    # Explicit process-only overrides for evidence diffs and fixture staging.
    # Real-repository status/source gates use the unchanged effective Git settings.
    $options = @()
    foreach ($setting in $CommandConfiguration) {
        if (@('core.autocrlf=false', 'core.eol=lf', 'core.safecrlf=false', 'core.whitespace=blank-at-eol,blank-at-eof,space-before-tab,cr-at-eol') -cnotcontains $setting) { throw 'STOP: unapproved temporary Git option.' }
        $options += '-c'; $options += $setting
    }
    $command = Get-Command git -CommandType Application -ErrorAction Stop | Select-Object -First 1
    $previousOutputEncoding = [Console]::OutputEncoding
    try {
        # Windows PowerShell decodes native stdout using the console output code page.
        # Git emits UTF-8; decoding it as CP850 corrupts accented diff content.
        [Console]::OutputEncoding = New-Object Text.UTF8Encoding($false, $true)
        $rows = @(& $command.Path --no-pager --no-optional-locks -c core.fsmonitor=false -c core.untrackedCache=false -c core.pager=cat -c core.quotePath=true @options -C $Root @Arguments 2>$null)
        $gitExit = $LASTEXITCODE
    } finally { [Console]::OutputEncoding = $previousOutputEncoding }
    if ($AllowedExitCodes -notcontains $gitExit) { throw 'STOP: read-only Git operation failed.' }
    return ,$rows
}
function Assert-AIOSDiffRoundTrip {
    param([string[]]$Rows, [byte[]]$Before, [byte[]]$After)
    $utf8 = New-Object Text.UTF8Encoding($false, $true)
    # Preserve BOM as an actual first-line character, normalize EOL only for Git's text view.
    $oldText = $utf8.GetString($Before).Replace("`r`n", "`n")
    $newText = $utf8.GetString($After).Replace("`r`n", "`n")
    $oldLines = @()
    if ($oldText.Length -gt 0) {
        $oldLines = @($oldText -split "`n")
        if ($oldText.EndsWith("`n")) { $oldLines = @($oldLines[0..($oldLines.Count - 2)]) }
    }
    $rebuilt = New-Object 'Collections.Generic.List[string]'
    $cursor = 0; $hunks = 0; $inHunk = $false
    $oldExpected = 0; $newExpected = 0; $oldSeen = 0; $newSeen = 0
    foreach ($row in $Rows) {
        $header = [regex]::Match($row, '^@@ -([0-9]+)(?:,([0-9]+))? \+([0-9]+)(?:,([0-9]+))? @@')
        if ($header.Success) {
            if ($inHunk -and ($oldSeen -ne $oldExpected -or $newSeen -ne $newExpected)) { throw 'STOP: diff hunk length mismatch.' }
            $oldExpected = $(if ($header.Groups[2].Success) { [int]$header.Groups[2].Value } else { 1 })
            $newExpected = $(if ($header.Groups[4].Success) { [int]$header.Groups[4].Value } else { 1 })
            $oldStart = [int]$header.Groups[1].Value
            $newStart = [int]$header.Groups[3].Value
            $oldTarget = $(if ($oldExpected -eq 0) { $oldStart } else { $oldStart - 1 })
            $newTarget = $(if ($newExpected -eq 0) { $newStart } else { $newStart - 1 })
            if ($oldTarget -lt $cursor -or $oldTarget -gt $oldLines.Count) { throw 'STOP: diff hunk position mismatch.' }
            while ($cursor -lt $oldTarget) { $rebuilt.Add([string]$oldLines[$cursor]); $cursor++ }
            if ($rebuilt.Count -ne $newTarget) { throw 'STOP: diff postimage position mismatch.' }
            $oldSeen = 0; $newSeen = 0; $hunks++; $inHunk = $true
            continue
        }
        if (-not $inHunk) { continue }
        if ($row -ceq '\ No newline at end of file') { continue }
        if ($row.Length -eq 0) { throw 'STOP: empty diff body line.' }
        $sign = $row.Substring(0, 1); $body = $row.Substring(1)
        if ($sign -ceq ' ' -or $sign -ceq '-') {
            if ($cursor -ge $oldLines.Count -or -not [string]::Equals($body, [string]$oldLines[$cursor], [StringComparison]::Ordinal)) { throw 'STOP: diff preimage text/encoding mismatch.' }
            $cursor++; $oldSeen++
        }
        if ($sign -ceq ' ' -or $sign -ceq '+') { $rebuilt.Add($body); $newSeen++ }
        elseif ($sign -cne '-') { throw 'STOP: unknown diff body line.' }
    }
    if ($hunks -eq 0 -or $oldSeen -ne $oldExpected -or $newSeen -ne $newExpected) { throw 'STOP: incomplete predicted diff.' }
    while ($cursor -lt $oldLines.Count) { $rebuilt.Add([string]$oldLines[$cursor]); $cursor++ }
    $result = $rebuilt.ToArray() -join "`n"
    if ($newText.EndsWith("`n")) { $result += "`n" }
    if (-not [string]::Equals($result, $newText, [StringComparison]::Ordinal)) { throw 'STOP: diff postimage text/encoding mismatch.' }
}
function Read-AIOSGitOne {
    param([string]$Root, [string[]]$Arguments)
    $rows = Read-AIOSGit $Root $Arguments
    if ($rows.Count -ne 1) { throw 'STOP: ambiguous Git result.' }
    return [string]$rows[0]
}
function Assert-AIOSDocumentDeltaWhitespace {
    param([string]$Root,[string]$BeforePath,[string]$AfterPath,[string[]]$DiffRows)
    $beforeLayout=Read-AIOSLayout ([IO.File]::ReadAllBytes($BeforePath))
    $afterLayout=Read-AIOSLayout ([IO.File]::ReadAllBytes($AfterPath))
    if($beforeLayout.Eol -cne $afterLayout.Eol -or $beforeLayout.Bom -ne $afterLayout.Bom){throw 'STOP: delta layout differs from preimage.'}
    $options=@('core.autocrlf=false','core.eol=lf','core.safecrlf=false')
    if($beforeLayout.Eol -ceq 'CRLF'){
        # Git's text check must recognize CR as part of the preserved line ending.
        # Keep the three default whitespace errors enabled; no repository config edit.
        $options+='core.whitespace=blank-at-eol,blank-at-eof,space-before-tab,cr-at-eol'
    }
    $diagnostics=Read-AIOSGit $Root @('diff','--no-ext-diff','--no-textconv','--check','--no-index','--',$BeforePath,$AfterPath) @(0,1,3) $options
    # Markdown's two-space hard break is intentional layout, including the
    # acquired header. Permit only that exact diagnostic/content pair. Conflict
    # markers, space-before-tab, blank EOF lines and other whitespace stop.
    if(($diagnostics.Count % 2) -ne 0){throw 'STOP: unexpected delta whitespace diagnostic.'}
    for($i=0;$i -lt $diagnostics.Count;$i+=2){
        $message=[string]$diagnostics[$i];$body=[string]$diagnostics[$i+1]
        if($message -cnotmatch ': trailing whitespace\.$' -or -not $body.StartsWith('+',[StringComparison]::Ordinal) -or
            $body -cnotmatch '\S  $' -or $DiffRows -cnotcontains $body){throw 'STOP: document delta whitespace error.'}
    }
}
function Assert-AIOSStatus {
    param([string]$Root, [string[]]$Expected, [string[]]$AppliedPaths = @())
    $actual = Read-AIOSGit $Root @('status', '--porcelain=v1', '--untracked-files=all')
    $a = @($actual | Sort-Object -CaseSensitive)
    $b = @($Expected | Sort-Object -CaseSensitive)
    if ($a.Count -ne $b.Count) { throw 'STOP: foreign or unexpected Git status.' }
    for ($i = 0; $i -lt $a.Count; $i++) { if ($a[$i] -cne $b[$i]) { throw 'STOP: foreign or unexpected Git status.' } }
}
function Assert-AIOSGitIdentity {
    param([object]$Context)
    $root = $Context.Root; $h = $Context.Handoff; $p = $Context.Policy
    Assert-AIOSPlainDirectory $root
    Assert-AIOSPlainDirectory (Join-Path $root '.git')
    if ([IO.Path]::GetFullPath((Read-AIOSGitOne $root @('rev-parse', '--show-toplevel'))).TrimEnd('\', '/') -ine $root) { throw 'STOP: Git root mismatch.' }
    if ((Read-AIOSGitOne $root @('symbolic-ref', '--quiet', '--short', 'HEAD')) -cne $h.repository.branch) { throw 'STOP: branch mismatch.' }
    if ((Read-AIOSGitOne $root @('rev-parse', '--verify', 'HEAD')) -cne $h.repository.expected_head) { throw 'STOP: HEAD mismatch.' }
    if ((Read-AIOSGitOne $root @('rev-parse', '--abbrev-ref', '--symbolic-full-name', '@{upstream}')) -cne ('origin/' + $h.repository.branch)) { throw 'STOP: upstream mismatch.' }
    if ((Read-AIOSGitOne $root @('rev-parse', '--verify', ('refs/remotes/origin/' + $h.repository.branch))) -cne $h.repository.expected_upstream_sha) { throw 'STOP: upstream hash mismatch.' }
    if ((Read-AIOSGit $root @('ls-files', '--unmerged')).Count -ne 0) { throw 'STOP: Git conflicts.' }
    foreach ($line in (Read-AIOSGit $root @('ls-files', '-v'))) { if (([string]$line) -cnotmatch '^H ') { throw 'STOP: special Git index flags.' } }
    foreach ($marker in @('MERGE_HEAD', 'CHERRY_PICK_HEAD', 'REVERT_HEAD', 'rebase-merge', 'rebase-apply', 'index.lock')) {
        if (Test-Path -LiteralPath (Read-AIOSGitOne $root @('rev-parse', '--path-format=absolute', '--git-path', $marker))) { throw 'STOP: Git operation in progress.' }
    }
    if ($p.origin_urls -cnotcontains (Read-AIOSGitOne $root @('remote', 'get-url', 'origin'))) { throw 'STOP: origin mismatch.' }
    Assert-AIOSExistingFile $Context.IndexPath
    if ((Get-AIOSHash ([IO.File]::ReadAllBytes($Context.IndexPath))) -cne $Context.IndexHash) { throw 'STOP: Git index changed.' }
}
function Assert-AIOSRemote {
    param([object]$Context)
    $oldPrompt = [Environment]::GetEnvironmentVariable('GIT_TERMINAL_PROMPT', 'Process')
    $oldGcm = [Environment]::GetEnvironmentVariable('GCM_INTERACTIVE', 'Process')
    try {
        $env:GIT_TERMINAL_PROMPT = '0'; $env:GCM_INTERACTIVE = 'Never'
        $rows = Read-AIOSGit $Context.Root @('ls-remote', '--exit-code', '--heads', 'origin', ('refs/heads/' + $Context.Handoff.repository.branch))
    } finally {
        [Environment]::SetEnvironmentVariable('GIT_TERMINAL_PROMPT', $oldPrompt, 'Process')
        [Environment]::SetEnvironmentVariable('GCM_INTERACTIVE', $oldGcm, 'Process')
    }
    $expected = $Context.Handoff.repository.expected_upstream_sha + "`trefs/heads/" + $Context.Handoff.repository.branch
    if ($rows.Count -ne 1 -or $rows[0] -cne $expected) { throw 'STOP: live remote mismatch.' }
}
function Assert-AIOSMetricsEqual {
    param([object]$Actual, [object]$Expected)
    foreach ($key in @('words', 'characters_utf16', 'paragraphs', 'headings', 'bytes')) {
        if ($Actual.$key -ne $Expected[$key]) { throw ('STOP: CQD metric mismatch: ' + $key) }
    }
}
function Assert-AIOSSourceGuard {
    param([object]$Context, [string[]]$Applied = @())
    foreach ($source in $Context.Handoff.sources) {
        if ($source.commit -cne $Context.Handoff.source_snapshot.commit) { throw 'STOP: source commit mismatch.' }
        if ((Read-AIOSGitOne $Context.Root @('rev-parse', ('HEAD:' + $source.path))) -cne $source.blob_sha1) { throw 'STOP: source Git blob mismatch.' }
        $path = Resolve-AIOSSourcePath $Context.Root $source.path
        Assert-AIOSExistingFile $path
        $expected = $source.working_sha256
        if ($Applied -ccontains $source.path) {
            $file = @($Context.Handoff.files | Where-Object { $_.path -ceq $source.path })[0]
            $expected = $file.post_sha256
        }
        if ((Get-AIOSHash ([IO.File]::ReadAllBytes($path))) -cne $expected) { throw 'STOP: source working-copy hash mismatch.' }
    }
    foreach ($evidence in $Context.Policy.instruction_files) {
        $exists = Test-Path -LiteralPath $evidence.path
        if ($exists -ne $evidence.exists) { throw 'STOP: instruction/configuration presence changed.' }
        if ($exists) {
            Assert-AIOSExistingFile $evidence.path
            if ($evidence.ContainsKey('guard')) {
                Assert-AIOSCodexSemanticConfig $evidence.path $Context.Root 'User'
            } elseif ((Get-AIOSHash ([IO.File]::ReadAllBytes($evidence.path))) -cne $evidence.sha256) { throw 'STOP: instruction/configuration hash changed.' }
        }
    }
}
function New-AIOSHandoffContext {
    param([string]$HandoffPath, [string]$PolicyPath, [string]$ProfilePath, [string]$EntryPath, [string]$ExpectedHandoffHash)
    throw 'STOP: LOGOS candidate excludes the legacy loader; use the pinned durable document entrypoint.'
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
        $h.repository.expected_upstream_sha -cne $h.repository.expected_head) { throw 'STOP: source snapshot cross-field mismatch.' }
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
    # Document lanes require the snapshot-aware entrypoint; this historical
    # clean-tree loader must never become an alternate document execution path.
    if (@('isolated-document-test','document-ranges') -ccontains $p.stage) { throw 'STOP: document lane requires the durable snapshot entrypoint.' }
    $root = [IO.Path]::GetFullPath($p.root).TrimEnd('\', '/')
    if ($p.stage -ceq 'isolated-test') {
        if ($p.origin_urls.Count -ne 1 -or $p.origin_urls[0] -cne 'C:\AIOS_GITHUB\AIOS_CORE') { throw 'STOP: fixture origin must be the read-only local source repository.' }
        $parent = [IO.Path]::GetFullPath((Join-Path ([IO.Path]::GetTempPath()) 'AIOS_CODEX_GATE_TESTS')).TrimEnd('\', '/')
        if (-not $root.StartsWith($parent + '\', [StringComparison]::OrdinalIgnoreCase)) { throw 'STOP: isolated-test root outside TEMP.' }
        $marker = Join-Path ([IO.Path]::GetDirectoryName($root)) '_AIOS_ISOLATED_FIXTURE.txt'
        Assert-AIOSExistingFile $marker
        if ([IO.File]::ReadAllText($marker) -cne 'AIOS_ISOLATED_TEST_ONLY') { throw 'STOP: fixture identity missing.' }
    } elseif ($root -cne 'C:\AIOS_GITHUB\AIOS_CORE' -or $p.project -cne 'AIOS_CORE' -or $p.repository -cne 'moody58/AIOS_CORE') { throw 'STOP: unapproved real project root.' }
    if ($p.stage -ceq 'pilot-check-only') {
        $approvedOrigins = @('https://github.com/moody58/AIOS_CORE.git', 'https://github.com/moody58/AIOS_CORE', 'git@github.com:moody58/AIOS_CORE.git', 'ssh://git@github.com/moody58/AIOS_CORE.git')
        foreach ($url in $p.origin_urls) { if ($approvedOrigins -cnotcontains $url) { throw 'STOP: real origin is outside approved repository identity.' } }
    }
    Assert-AIOSPlainDirectory $root
    $seen = @{}
    if ($p.stage -ceq 'pilot-check-only' -and ($h.files.Count -ne 1 -or $h.files[0].operation -cne 'create_text' -or
        $h.files[0].path -cne '05_WORKSPACE/05_AIOS_Codex_Document_Apply_Pilot.md')) { throw 'STOP: real Check is restricted to the non-critical pilot preview.' }
    foreach ($file in $h.files) {
        Assert-AIOSRelativePath $file.path
        if ($seen.ContainsKey($file.path)) { throw 'STOP: target path case collision.' }
        $seen[$file.path] = $true
        if ($p.allowed_paths -cnotcontains $file.path) { throw 'STOP: target outside policy allowlist.' }
        if ($file.operation -ceq 'modify_ranges' -and $file.pre_sha256 -ceq $file.post_sha256) { throw 'STOP: no-op modification excluded.' }
        if ($file.path -match '_v[0-9]+\.[0-9]+') { throw 'STOP: filename policy violation.' }
    }
    $indexPath = Read-AIOSGitOne $root @('rev-parse', '--path-format=absolute', '--git-path', 'index')
    Assert-AIOSExistingFile $indexPath
    $context = [pscustomobject]@{ Handoff = $h; Policy = $p; Profile = $profile; Root = $root; IndexPath = $indexPath;
        IndexHash = (Get-AIOSHash ([IO.File]::ReadAllBytes($indexPath))); HandoffPath = $HandoffPath; HandoffHash = $ExpectedHandoffHash;
        PolicyPath = $PolicyPath; ProfilePath = $ProfilePath; EntryPath = $EntryPath }
    Assert-AIOSGitIdentity $context
    Assert-AIOSStatus $root $p.expected_status
    Assert-AIOSRemote $context
    Assert-AIOSSourceGuard $context
    return $context
}
function Get-AIOSHandoffPrediction {
    param([object]$Context)
    $results = @()
    foreach ($file in $Context.Handoff.files) {
        if ($file.operation -ceq 'modify_ranges') {
            $path = Resolve-AIOSDocumentPath $Context.Root $file.path
            [byte[]]$before = [IO.File]::ReadAllBytes($path)
            $plan = [ordered]@{}
            foreach ($key in @('pre_sha256', 'post_sha256', 'encoding', 'eol', 'bom', 'final_newline', 'ranges', 'contains_once')) { $plan[$key] = $file[$key] }
            $result = New-AIOSPostimage $before $plan
            Assert-AIOSMetricsEqual $result.BeforeMetrics $file.metrics_before
            Assert-AIOSMetricsEqual $result.AfterMetrics $file.metrics_expected
            [byte[]]$post = $result.Bytes
        } else {
            $path = Resolve-AIOSDocumentPath $Context.Root $file.path $false
            [byte[]]$before = @()
            [byte[]]$post = ConvertTo-AIOSBytes $file.content_utf8 $file.eol $file.bom
            $layout = Read-AIOSLayout $post
            if ($layout.FinalNewline -ne $file.final_newline -or (Get-AIOSHash $post) -cne $file.post_sha256) { throw 'STOP: new document hash/layout mismatch.' }
            Assert-AIOSMetricsEqual (Get-AIOSMetrics $post) $file.metrics_expected
            foreach ($needle in $file.contains_once) {
                if ([regex]::Matches($layout.Text, [regex]::Escape($needle)).Count -ne 1) { throw 'STOP: new document structural postcondition failed.' }
            }
        }
        $results += [pscustomobject]@{ File = $file; Path = $path; Before = $before; After = $post }
    }
    Assert-AIOSGitIdentity $Context
    Assert-AIOSStatus $Context.Root $Context.Policy.expected_status
    Assert-AIOSSourceGuard $Context
    Assert-AIOSRemote $Context
    return ,$results
}
