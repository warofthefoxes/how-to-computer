$HTComputer = "C:\Users\Louis\Desktop\StartupFiles\howtocomputer.txt"
$libraryPath = "C:\Users\Louis\Desktop\StartupFiles\Library\"
$YN = @("YES","NO")
## Region Functions

function folderMenu {
    write-host "=== FOLDERS IN LIBRARY ==="
    $folderOpts = @()
    $folderOpts += Get-ChildItem -Path $libraryPath
    $chosenDir = Show-Menu -MenuItems $folderOpts
    Write-Host $chosenDir

    $chosenFilepath = -join($libraryPath,$chosenDir)
#    Write-Host $chosenFilepath
    Clear-Host
    }
#adds files in chosen folder to array, adds array to psmenu
function fileMenu 
    {
    Clear-Host
    write-host ("=== FILES IN", $chosenDir, "===")
    $Opts = @()
    $Opts += Get-ChildItem -Path $chosenFilepath
    $pickfile = Show-Menu -MenuItems $Opts
    Clear-Host
    }
function displayText {
    write-host ("TEXT IN",$pickFile)
    get-content $chosenFilepath\$pickfile
    }
# establishes variables and changes dir to startdir
# need to add one-time script to set library dir
    function ChangeDir {
    $StartDir = "C:\Users\Louis\Desktop\StartupFiles"
    $LibraryDir = "C:\Users\Louis\Desktop\StartupFiles\Library"
    Set-Location $StartDir
}
# checks if PSMenu is installed, installs if not
function checkInstallPSMenu {

    if (-not (Get-Module ps-menu -ListAvailable))
        {
    Install-Module ps-menu -Scope CurrentUser -Force
        }

}

# asks if user wants to create a file, takes filename, checks for/appends .txt
# takes contents, adds to file.
# kind of a mess. could be more concise. 
function FileCreate {
    write-host "Would you like to create a new file?"
    $fileYN = Show-Menu -MenuItems $YN 
    
    if ($fileYN = "Y") {
            Clear-Host
            $FileCreateName = Read-Host ">>>>> What should the filename be?"
            if ($FileCreateName -inotcontains ".txt") {
                $FileCreateName = -Join ($FileCreateName,".txt")
                }
        Clear-Host
        $FileContents = Read-Host ">>>>> Please type your contents."
        New-Item $LibraryDir\"$FileCreateName"
        Add-Content -Path .\$FileCreateName -Value $FileContents
        }
        # should change above to open file in notepad.exe ?
        # do I need the below?
    elseIf ($FileYesNo -inotmatch "n" -and $FileYesNo -inotmatch "y" ) {
        Write-Host "OK"
        }
    }

function openFolderFileMenu {
    $openYN = Show-Menu -MenuItems $YN
    If ($openYN = 'Y') {
        folderMenu
        fileMenu
        displayText
    }
    else {
        
    }
}
function FileYn {
    $FileYesNo = Read-Host -Prompt ">>>>> Would you like to open a text file? y/n"
     If ( $FileYesNo -imatch "y" ) {
      <# Set-Location "C:\Users\Louis\Desktop\StartupFiles\Library"
        # even after calling ChangeDir, $LibraryDir was unreadable. Why?
       Get-ChildItem
        # write cooler code to replace this / implement ps-menu
        $FileInput = Read-Host -prompt ">>>>> Which file?"
        $FileName = -join("$FileInput",".txt")
       Clear-Host
       displayColorText $FileName
       #>
       folderMenu
     }
     elseIf ($FileYesNo -imatch "n") {
        # $FileCreate = Read-Host ">>>>> Would you like to create a text file? y/n"
        FileCreate
     }
 }

# need to add a way to tell if the filename entered is valid without breaking the code
# need to add a way to tell if filename was entered with extension other than .txt
# ps-menu might break both of these or render them unnecessary

function Get-textColor {
    Param([Parameter(Position=0)]
    [String]$textEntry)

    process {
        if ($textEntry.Contains("delete or move this document")) {Return "Red"}
            elseif ($textEntry.Contains("====")) {Return "Blue"}
	        elseif ($textEntry.Contains("++++++")) {Return "Blue"}
            elseif ($textEntry.Contains("USERNAME")) {Return "Green"}
	        elseif ($textEntry.Contains("COMMAND")) {Return "Green"}
	        elseif ($textEntry.Contains("REPO")) {Return "Green"}
	        elseif ($textEntry.Contains("FIX")) {Return "Green"} 
        	elseif ($textEntry.Contains("*")) {Return "Magenta"}
        else {Return "Yellow"}
    }
}

function displayColorText {
    param ($fileInput)
    get-content $fileInput | ForEach {Write-Host -ForegroundColor (Get-textColor $_) $_}
} 

# Region Main

Do {
Clear-Host
ChangeDir
checkInstallPSMenu
openFolderFileMenu
# displayColorText $HTComputer

# FileYn 
$Continue = Read-host -Prompt "Enter X to exit"

} while ( $Continue -notcontains "X")

# $null = Read-Host -Prompt "Press any key to close window."
    # need better way to prevent the window from closing once the code completes
    # possibly use a loop as in previous java projects
