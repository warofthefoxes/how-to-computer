$HTComputer = "C:\Users\Louis\Desktop\StartupFiles\howtocomputer.txt"

## Functions

# establishes variables and changes dir to startdir
# need to change this so the paths aren't hard-coded
    # possibly create function to check for and create Library folder within current dir
function ChangeDir {
    $StartDir = "C:\Users\Louis\Desktop\StartupFiles"
    $LibraryDir = "C:\Users\Louis\Desktop\StartupFiles\Library"
    cd $StartDir
}

# checks if PSMenu is installed, installs if not
function checkInstallPSMenu {

    if (-not (Get-Module ps-menu -ListAvailable))
        {
    Install-Module ps-menu -Scope CurrentUser -Force
        }

}

# asks if user wants to create a file, takes filename, checks for/appends .txt
function FileCreate {
    $FileYN = Read-Host -Prompt ">>>>> Would you like to create a text file? y/n"
    If ($FileYN -imatch "y") {
        
        cd $LibraryDir
        
        $FileCreateName = Read-Host ">>>>> What should the filename be?"
        $TxtYN = $FileCreateName -inotcontains ".txt"
            if ($TxtYN = $true) {
             $FileCreateName = -Join ($FileCreateName,".txt")
             }
        
        $FileContents = Read-Host ">>>>> Please type your contents."
        New-Item $LibraryDir\"$FileCreateName"
        Add-Content -Path .\$FileCreateName -Value $FileContents
        }
    elseIf ($FileYesNo -inotmatch "n" -and $FileYesNo -inotmatch "y" ) {
        Write-Host "OK"
    }

 }


 # asks if user wants to open a file, clears console and displays text
function FileYn {
    $FileYesNo = Read-Host -Prompt ">>>>> Would you like to open a text file? y/n"
     If ( $FileYesNo -imatch "y" ) {
       cd "C:\Users\Louis\Desktop\StartupFiles\Library"
        # even after calling ChangeDir, $LibraryDir was unreadable. Why?
       dir
        # write cooler code to replace this / implement ps-menu
        $FileInput = Read-Host -prompt ">>>>> Which file?"
        $FileName = -join("$FileInput",".txt")
       Clear-Host
       displayColorText $FileName
     }
     elseIf ($FileYesNo -imatch "n") {
        # $FileCreate = Read-Host ">>>>> Would you like to create a text file? y/n"
        FileCreate
     }
 }

 #function to test if input contains ".txt"
 #broken, needs cleaned
<# $TextString = "no.txt"
function ContainsTxt {
    If ($TextString.Contains(".txt.")) {
        $YN = TR
      }
    else {
        $YN = FALSE
      }
}

# ContainsTxt($TextString)
Write-Host $YN
#>


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

Clear-Host
ChangeDir
checkInstallPSMenu

displayColorText $HTComputer

# $null = Read-Host -Prompt "Press the ANY key"
# change this to prompt for user input

FileYn

$null = Read-Host -Prompt "Press any key to close window."
    # need better way to prevent the window from closing once the code completes
    # possibly use a loop as in previous java projects
