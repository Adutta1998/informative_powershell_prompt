# informative_powershell_prompt

### Windows Powershell is a handy tool but the basic prompt is too boring..
### So here is a new Prompt you can try 🥳🥳🥳

1. It shows the profile you are using
2. It shows if the terminal is elevated or not
3. It shows the number of file, directories, and size of the Directory(not recursive)
4. It shows the current path you are working on
5. It shows the git status as well:
    - Where you are in a which branch
    - the branch status also
        - maybe the branch is clean or have un-commited files or have untracked files

6. The colors is more productive, predictive and informative.
7. #### The most Important: You are also a designer, Just change it to as you like.

Open Your powershell and write
```powershell
notepad $profile
```

copy the code from .ps1 file to your profie.
```powershell
function prompt {
    $status = ""
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $files = (Get-ChildItem  | Measure-Object -Property Length -sum)
    $directories=(Get-ChildItem -Directory | Measure-Object)
    $nDirectories = $directories.count
    $nfiles = $files.count
    $size = (& { If (($files.sum / 1gb) -gt 1 ) { ("{0:N1}G" -f ($files.sum / 1gb)) } Else { ("{0:N1}M" -f ($files.sum / 1Mb)) } })
    $dt = Get-Date -Format "dd-MMM-yy HH:mm::ss"
    try { ........
```

refresh the powershell.. ### and Done ❤.
