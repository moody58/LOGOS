# AIOS document safety core v0.2 - candidate, isolated-fixture use only.
# This is NOT the production DOC-HANDOFF executor: Git/JSON/profile gates come next.
Set-StrictMode -Version 2.0

function Get-AIOSHash {
    param([byte[]]$Bytes)
    $algorithm = [Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($algorithm.ComputeHash($Bytes))).Replace('-', '').ToLowerInvariant() }
    finally { $algorithm.Dispose() }
}

function ConvertTo-AIOSBytes {
    param([string]$Text, [ValidateSet('LF', 'CRLF')][string]$Eol = 'LF', [bool]$Bom = $false)
    if ($Text.Contains("`r")) { throw 'STOP: range text must use LF only.' }
    if ($Text.Contains([char]0)) { throw 'STOP: NUL content is excluded.' }
    $wire = $Text
    if ($Eol -eq 'CRLF') { $wire = $Text.Replace("`n", "`r`n") }
    $encoding = New-Object Text.UTF8Encoding($false, $true)
    [byte[]]$bytes = $encoding.GetBytes($wire)
    if ($Bom) { $bytes = [byte[]](@(239, 187, 191) + @($bytes)) }
    return ,$bytes
}

function Read-AIOSLayout {
    param([byte[]]$Bytes)
    $encoding = New-Object Text.UTF8Encoding($false, $true)
    $offset = 0
    $bom = $false
    if ($Bytes.Length -ge 3 -and $Bytes[0] -eq 239 -and $Bytes[1] -eq 187 -and $Bytes[2] -eq 191) {
        $offset = 3
        $bom = $true
    }
    try { $text = $encoding.GetString($Bytes, $offset, $Bytes.Length - $offset) }
    catch { throw 'STOP: file is not valid UTF-8.' }
    if ($text.Contains([char]0)) { throw 'STOP: binary/NUL content is excluded.' }
    $eol = 'LF'
    if ($text.Contains("`r")) {
        $rest = $text.Replace("`r`n", '')
        if ($rest.Contains("`r") -or $rest.Contains("`n")) { throw 'STOP: mixed or unsupported line endings.' }
        $eol = 'CRLF'
    }
    $normalized = $text.Replace("`r`n", "`n")
    return [pscustomobject]@{ Text = $normalized; Eol = $eol; Bom = $bom; FinalNewline = $normalized.EndsWith("`n") }
}

function Assert-AIOSFields {
    param([object]$Object, [string[]]$Names)
    if ($Object -is [Collections.IDictionary]) { $actual = @($Object.Keys | ForEach-Object { [string]$_ }) }
    else { $actual = @($Object.PSObject.Properties | ForEach-Object { $_.Name }) }
    if ($actual.Count -ne $Names.Count) { throw 'STOP: missing or unknown fields.' }
    foreach ($name in $actual) {
        if (-not ($Names -ccontains $name)) { throw 'STOP: unknown or incorrectly cased field.' }
    }
}

function Get-AIOSMetrics {
    param([byte[]]$Bytes)
    $layout = Read-AIOSLayout -Bytes $Bytes
    $text = $layout.Text
    $paragraphs = 0
    if ($text.Trim().Length -gt 0) { $paragraphs = [regex]::Split($text.Trim(), '\n[ \t]*\n+').Count }
    return [pscustomobject]@{
        words = [regex]::Matches($text, '\S+').Count
        characters_utf16 = $text.Length
        paragraphs = $paragraphs
        headings = [regex]::Matches($text, '(?m)^#{1,6} +\S').Count
        bytes = $Bytes.Length
        sha256 = Get-AIOSHash -Bytes $Bytes
    }
}

function New-AIOSPostimage {
    param([byte[]]$Before, [object]$Plan)
    Assert-AIOSFields -Object $Plan -Names @('pre_sha256', 'post_sha256', 'encoding', 'eol', 'bom', 'final_newline', 'ranges', 'contains_once')
    if ($Plan.pre_sha256 -cnotmatch '^[0-9a-f]{64}$' -or $Plan.post_sha256 -cnotmatch '^[0-9a-f]{64}$') {
        throw 'STOP: invalid file hash.'
    }
    if ((Get-AIOSHash -Bytes $Before) -cne $Plan.pre_sha256) { throw 'STOP: preimage hash mismatch.' }
    if ($Plan.encoding -cne 'utf-8') { throw 'STOP: unsupported encoding.' }
    if ($Plan.bom -isnot [bool] -or $Plan.final_newline -isnot [bool]) { throw 'STOP: layout booleans are required.' }
    $layout = Read-AIOSLayout -Bytes $Before
    if ($layout.Eol -cne $Plan.eol -or $layout.Bom -ne $Plan.bom -or $layout.FinalNewline -ne $Plan.final_newline) {
        throw 'STOP: file layout mismatch.'
    }
    if ($Plan.ranges -isnot [array] -or $Plan.ranges.Count -lt 1 -or $Plan.ranges.Count -gt 32) {
        throw 'STOP: one to 32 explicit ranges are required.'
    }
    if ($Plan.contains_once -isnot [array] -or $Plan.contains_once.Count -lt 1) { throw 'STOP: structural postconditions are required.' }
    $resolved = @()
    $ids = @{}
    $lastEnd = -1
    foreach ($range in $Plan.ranges) {
        Assert-AIOSFields -Object $range -Names @('anchor_id', 'start_marker', 'end_marker', 'before_utf8', 'after_utf8', 'before_sha256', 'after_sha256')
        foreach ($key in @('anchor_id', 'start_marker', 'end_marker', 'before_utf8', 'after_utf8', 'before_sha256', 'after_sha256')) {
            if ($range.$key -isnot [string]) { throw 'STOP: range fields must be strings.' }
        }
        if ($range.anchor_id -cnotmatch '^[a-zA-Z0-9_.-]+$' -or $ids.ContainsKey($range.anchor_id)) {
            throw 'STOP: invalid or duplicate anchor ID.'
        }
        $ids[$range.anchor_id] = $true
        foreach ($marker in @($range.start_marker, $range.end_marker)) {
            if ($marker.Length -eq 0 -or $marker.Contains("`n") -or $marker.Contains("`r")) { throw 'STOP: markers must be nonempty single lines.' }
        }
        if ($range.start_marker -ceq $range.end_marker) { throw 'STOP: identical range delimiters.' }
        $startMatches = @([regex]::Matches($layout.Text, ('(?m)^' + [regex]::Escape($range.start_marker) + '(?=\n|$)')))
        $endMatches = @([regex]::Matches($layout.Text, ('(?m)^' + [regex]::Escape($range.end_marker) + '(?=\n|$)')))
        if ($startMatches.Count -ne 1 -or $endMatches.Count -ne 1) { throw 'STOP: absent or ambiguous marker.' }
        $start = $startMatches[0].Index
        $end = $endMatches[0].Index
        if ($start -ge $end -or $start -lt $lastEnd) { throw 'STOP: reversed, unsorted or overlapping ranges.' }
        if ($start -eq 0 -and $end -ge $layout.Text.Length) { throw 'STOP: whole-file replacement is excluded.' }
        $old = $layout.Text.Substring($start, $end - $start)
        if ($old -cne $range.before_utf8) { throw 'STOP: before text mismatch.' }
        if ($range.before_sha256 -cnotmatch '^[0-9a-f]{64}$' -or $range.after_sha256 -cnotmatch '^[0-9a-f]{64}$') {
            throw 'STOP: invalid range hash.'
        }
        $oldBytes = ConvertTo-AIOSBytes -Text $range.before_utf8 -Eol $layout.Eol
        $newBytes = ConvertTo-AIOSBytes -Text $range.after_utf8 -Eol $layout.Eol
        if ((Get-AIOSHash -Bytes $oldBytes) -cne $range.before_sha256 -or (Get-AIOSHash -Bytes $newBytes) -cne $range.after_sha256) {
            throw 'STOP: range hash mismatch.'
        }
        if (-not $range.after_utf8.EndsWith("`n")) { throw 'STOP: replacement must end before the next marker line.' }
        if (-not $range.after_utf8.StartsWith($range.start_marker + "`n", [StringComparison]::Ordinal)) {
            throw 'STOP: replacement must preserve its start marker.'
        }
        $resolved += [pscustomobject]@{ Start = $start; End = $end; After = $range.after_utf8; Anchor = $range.anchor_id }
        $lastEnd = $end
    }
    $builder = New-Object Text.StringBuilder
    $cursor = 0
    foreach ($range in $resolved) {
        [void]$builder.Append($layout.Text.Substring($cursor, $range.Start - $cursor))
        [void]$builder.Append($range.After)
        $cursor = $range.End
    }
    [void]$builder.Append($layout.Text.Substring($cursor))
    [byte[]]$post = ConvertTo-AIOSBytes -Text $builder.ToString() -Eol $layout.Eol -Bom $layout.Bom
    if ((Get-AIOSHash -Bytes $post) -cne $Plan.post_sha256) { throw 'STOP: calculated postimage hash mismatch.' }
    $postLayout = Read-AIOSLayout -Bytes $post
    if ($postLayout.FinalNewline -ne $layout.FinalNewline) { throw 'STOP: final newline changed.' }
    foreach ($range in $Plan.ranges) {
        foreach ($marker in @($range.start_marker, $range.end_marker)) {
            if ([regex]::Matches($postLayout.Text, ('(?m)^' + [regex]::Escape($marker) + '(?=\n|$)')).Count -ne 1) {
                throw 'STOP: postimage marker is absent or ambiguous.'
            }
        }
    }
    foreach ($needle in $Plan.contains_once) {
        if ($needle -isnot [string] -or $needle.Length -eq 0) { throw 'STOP: invalid structural postcondition.' }
        if ([regex]::Matches($postLayout.Text, [regex]::Escape($needle)).Count -ne 1) { throw 'STOP: structural postcondition failed.' }
    }
    return [pscustomobject]@{ Bytes = $post; BeforeMetrics = (Get-AIOSMetrics -Bytes $Before); AfterMetrics = (Get-AIOSMetrics -Bytes $post); Ranges = $resolved }
}

function Assert-AIOSRelativePath {
    param([string]$Relative)
    if ([string]::IsNullOrWhiteSpace($Relative) -or $Relative.Contains('\') -or $Relative.Contains(':') -or
        [IO.Path]::IsPathRooted($Relative) -or $Relative -cnotmatch '\.md$') { throw 'STOP: invalid or non-Markdown path.' }
    foreach ($part in $Relative.Split('/')) {
        if ($part -eq '' -or $part -eq '.' -or $part -eq '..' -or $part.EndsWith('.') -or $part.EndsWith(' ') -or
            $part -match '[~<>"|?*\x00-\x1f]' -or $part -match '^(?i:CON|PRN|AUX|NUL|COM[0-9]|LPT[0-9])(?:\.|$)' -or
            $part -match '^(?i:\.git|\.codex|\.agents|tools)$' -or $part -match '^(?i:AGENTS(?:\.override)?\.md)$') {
            throw 'STOP: protected path or Windows alias.'
        }
    }
}

function Initialize-AIOSNativeFileGuard {
    if ($null -ne ('AIOSCandidateNative.FileGuard' -as [type])) { return }
    Add-Type -TypeDefinition @'
using System;
using System.IO;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;
namespace AIOSCandidateNative {
  public static class FileGuard {
    [StructLayout(LayoutKind.Sequential)] private struct Info {
      public uint Attributes;
      public System.Runtime.InteropServices.ComTypes.FILETIME Creation, Access, Write;
      public uint Volume, SizeHigh, SizeLow, Links, IndexHigh, IndexLow;
    }
    [DllImport("kernel32.dll", SetLastError=true)] private static extern bool
      GetFileInformationByHandle(SafeFileHandle handle, out Info info);
    [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)] public static extern bool
      CreateHardLink(string newName, string existingName, IntPtr security);
    public static void ReplaceWithoutExtraBackup(string source, string destination) {
      // A C# null avoids Windows PowerShell 5.1 converting $null to an empty path.
      // The verified recovery backup has already been written by the caller.
      File.Replace(source, destination, null);
    }
    public static uint LinkCount(string path) {
      using (var file = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read)) {
        Info info;
        if (!GetFileInformationByHandle(file.SafeFileHandle, out info))
          throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());
        return info.Links;
      }
    }
  }
}
'@ -ErrorAction Stop
}

function Assert-AIOSExistingFile {
    param([string]$Path)
    $parent = New-Object IO.DirectoryInfo([IO.Path]::GetDirectoryName($Path))
    while ($null -ne $parent) {
        if (-not $parent.Exists -or ($parent.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
            throw 'STOP: missing parent, symlink or junction.'
        }
        $parent = $parent.Parent
    }
    if (-not [IO.File]::Exists($Path)) { throw 'STOP: file must exist.' }
    if (([IO.File]::GetAttributes($Path) -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'STOP: linked file.' }
    Initialize-AIOSNativeFileGuard
    if ([AIOSCandidateNative.FileGuard]::LinkCount($Path) -ne 1) { throw 'STOP: hardlinked file.' }
}

function Resolve-AIOSFixtureTarget {
    param([string]$Root, [string]$Relative)
    Assert-AIOSRelativePath -Relative $Relative
    $fullRoot = [IO.Path]::GetFullPath($Root).TrimEnd('\', '/')
    $allowedParent = [IO.Path]::GetFullPath((Join-Path ([IO.Path]::GetTempPath()) 'AIOS_CODEX_SAFE_APPLY_TESTS')).TrimEnd('\', '/')
    if (-not $fullRoot.StartsWith($allowedParent + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw 'STOP: candidate writes are restricted to isolated TEMP fixtures.'
    }
    $marker = Join-Path $fullRoot '_AIOS_ISOLATED_FIXTURE.txt'
    Assert-AIOSExistingFile -Path $marker
    if (-not [IO.File]::Exists($marker) -or [IO.File]::ReadAllText($marker) -cne 'AIOS_ISOLATED_TEST_ONLY') {
        throw 'STOP: fixture identity is missing.'
    }
    $target = [IO.Path]::GetFullPath((Join-Path $fullRoot $Relative))
    if (-not $target.StartsWith($fullRoot + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw 'STOP: target outside fixture.'
    }
    Assert-AIOSExistingFile -Path $target
    return $target
}

function Get-AIOSPlanHash {
    param([object]$Plan)
    # Stable within this native test implementation; final JSON serializer is a separate gate.
    $wire = ($Plan | ConvertTo-Json -Depth 12 -Compress)
    $encoding = New-Object Text.UTF8Encoding($false, $true)
    return Get-AIOSHash -Bytes $encoding.GetBytes($wire)
}

function Invoke-AIOSFixtureApply {
    param([string]$Root, [string]$Relative, [object]$Plan, [string]$ApprovedPlanHash)
    if ($ApprovedPlanHash -cne (Get-AIOSPlanHash -Plan $Plan)) { throw 'STOP: plan approval hash mismatch.' }
    $target = Resolve-AIOSFixtureTarget -Root $Root -Relative $Relative
    [byte[]]$before = [IO.File]::ReadAllBytes($target)
    $result = New-AIOSPostimage -Before $before -Plan $Plan
    $transaction = Join-Path $Root ('recovery_' + [Guid]::NewGuid().ToString('N'))
    [void][IO.Directory]::CreateDirectory($transaction)
    $backup = Join-Path $transaction 'preimage.bin'
    $staged = Join-Path $transaction 'postimage.bin'
    [IO.File]::WriteAllBytes($backup, $before)
    [IO.File]::WriteAllBytes($staged, $result.Bytes)
    if ((Get-AIOSHash -Bytes ([IO.File]::ReadAllBytes($backup))) -cne $Plan.pre_sha256 -or
        (Get-AIOSHash -Bytes ([IO.File]::ReadAllBytes($staged))) -cne $Plan.post_sha256) { throw 'STOP: recovery verification failed.' }
    $journal = [ordered]@{ state = 'PREPARED'; relative = $Relative; pre_sha256 = $Plan.pre_sha256; post_sha256 = $Plan.post_sha256; approved_plan_hash = $ApprovedPlanHash }
    $journalPath = Join-Path $transaction 'journal.json'
    $encoding = New-Object Text.UTF8Encoding($false)
    [IO.File]::WriteAllText($journalPath, ($journal | ConvertTo-Json), $encoding)
    $target = Resolve-AIOSFixtureTarget -Root $Root -Relative $Relative
    if ((Get-AIOSHash -Bytes ([IO.File]::ReadAllBytes($target))) -cne $Plan.pre_sha256) { throw 'STOP: preimage changed immediately before write.' }
    # Single-file atomic replacement; backup remains outside the target.
    [AIOSCandidateNative.FileGuard]::ReplaceWithoutExtraBackup($staged, $target)
    if ((Get-AIOSHash -Bytes ([IO.File]::ReadAllBytes($target))) -cne $Plan.post_sha256) {
        $journal.state = 'PARTIAL'
        [IO.File]::WriteAllText($journalPath, ($journal | ConvertTo-Json), $encoding)
        throw 'STOP: post-write verification failed; preserve recovery.'
    }
    $journal.state = 'APPLIED'
    [IO.File]::WriteAllText($journalPath, ($journal | ConvertTo-Json), $encoding)
    return [pscustomobject]@{ Target = $target; Backup = $backup; JournalPath = $journalPath; BeforeHash = $Plan.pre_sha256; AfterHash = $Plan.post_sha256; PlanHash = $ApprovedPlanHash; BeforeMetrics = $result.BeforeMetrics; AfterMetrics = $result.AfterMetrics }
}

function Invoke-AIOSFixtureRollback {
    param([string]$Root, [string]$Relative, [object]$Receipt, [string]$ApprovedPlanHash)
    if ($ApprovedPlanHash -cne $Receipt.PlanHash) { throw 'STOP: rollback approval hash mismatch.' }
    $target = Resolve-AIOSFixtureTarget -Root $Root -Relative $Relative
    if ($target -cne $Receipt.Target) { throw 'STOP: rollback target differs from receipt.' }
    $backupPath = [IO.Path]::GetFullPath($Receipt.Backup)
    $rootPrefix = [IO.Path]::GetFullPath($Root).TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
    if (-not $backupPath.StartsWith($rootPrefix, [StringComparison]::OrdinalIgnoreCase)) { throw 'STOP: unsafe backup path.' }
    Assert-AIOSExistingFile -Path $backupPath
    $journalPath = Join-Path ([IO.Path]::GetDirectoryName($backupPath)) 'journal.json'
    if ($journalPath -cne $Receipt.JournalPath) { throw 'STOP: journal differs from receipt.' }
    Assert-AIOSExistingFile -Path $journalPath
    [byte[]]$backup = [IO.File]::ReadAllBytes($backupPath)
    if ((Get-AIOSHash -Bytes $backup) -cne $Receipt.BeforeHash) { throw 'STOP: backup hash mismatch.' }
    if ((Get-AIOSHash -Bytes ([IO.File]::ReadAllBytes($target))) -cne $Receipt.AfterHash) { throw 'STOP: target changed after Apply; rollback refused.' }
    $rollbackFile = Join-Path ([IO.Path]::GetDirectoryName($backupPath)) ('rollback_' + [Guid]::NewGuid().ToString('N') + '.bin')
    [IO.File]::WriteAllBytes($rollbackFile, $backup)
    $target = Resolve-AIOSFixtureTarget -Root $Root -Relative $Relative
    if ((Get-AIOSHash -Bytes ([IO.File]::ReadAllBytes($target))) -cne $Receipt.AfterHash) { throw 'STOP: target changed immediately before rollback.' }
    [AIOSCandidateNative.FileGuard]::ReplaceWithoutExtraBackup($rollbackFile, $target)
    if ((Get-AIOSHash -Bytes ([IO.File]::ReadAllBytes($target))) -cne $Receipt.BeforeHash) { throw 'STOP: rollback verification failed.' }
    $journal = [ordered]@{ state = 'ROLLED_BACK'; relative = $Relative; pre_sha256 = $Receipt.BeforeHash; post_sha256 = $Receipt.AfterHash; approved_plan_hash = $ApprovedPlanHash }
    [IO.File]::WriteAllText($journalPath, ($journal | ConvertTo-Json), (New-Object Text.UTF8Encoding($false)))
    return [pscustomobject]@{ state = 'ROLLED_BACK'; sha256 = $Receipt.BeforeHash; backup_preserved = [IO.File]::Exists($backupPath) }
}
