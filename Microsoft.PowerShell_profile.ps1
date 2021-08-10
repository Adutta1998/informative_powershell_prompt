$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$OutputEncoding = [ System.Text.Encoding]::UTF8


function prompt {
    $status = ""
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $files = (Get-ChildItem  | Measure-Object -Property Length -sum)
    $directories=(Get-ChildItem -Directory | Measure-Object)
    $nDirectories = $directories.count
    $nfiles = $files.count
    $size = (& { If (($files.sum / 1gb) -gt 1 ) { ("{0:N1}G" -f ($files.sum / 1gb)) } Else { ("{0:N1}M" -f ($files.sum / 1Mb)) } })
    $dt = Get-Date -Format "dd-MMM-yy HH:mm::ss"
    try {

        $GitHEADFile = Get-Content '.\.git\HEAD'
        $GitHEADFileLine = [System.Environment]::NewLine
        $GitHEADFileContent = [String]::Join($GitHEADFileLine, $GitHEADFile)
        $GitHEADFileContentSplits = $GitHEADFileContent.split("/")
        $BranchName = $GitHEADFileContentSplits[$GitHEADFileContentSplits.Count - 1]
        if (git status --porcelain | Where-Object { $_ -match '^\?\?' }) {
            $status = "-un-tracked"
        }
        elseif (git status --porcelain | Where-Object { $_ -notmatch '^\?\?' }) {
            $status = "-un-commited"
        }
        else {
            $status = "-clean"
        }
    }
    catch {

    }

    # Check Elevated
    Write-Host "┌─" -ForegroundColor Magenta -NoNewline
    if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host " (elevated) "-ForegroundColor DarkBlue -NoNewline
    }
    else {
        Write-Host "($,$size,d-$nDirectories,f-$nfiles) " -ForegroundColor DarkCyan -NoNewline
    }

    #current directory
    Write-Host "{$PWD}" -ForegroundColor Yellow -NoNewline

    if ($BranchName.length -gt 0) {
        Write-Host "(*$BranchName $status)" -ForegroundColor Green
    }
    else {
        Write-Host "" -ForegroundColor Green
    }



    # Write-Host "`u{2665}" -ForegroundColor Red -NoNewline
    Write-Host "└───" -ForegroundColor Magenta -BackgroundColor Black -NoNewline
    return ":"
} #end prompt function
