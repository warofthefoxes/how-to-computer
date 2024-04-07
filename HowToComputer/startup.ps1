$textFile = "./howtocomputer.txt"

function Get-textColor {
    Param([Parameter(Position=0)]
    [String]$textEntry)

    process {
        if ($textEntry.Contains("====")) {Return "Blue"}
	elseif ($textEntry.Contains("++++++")) {Return "Blue"}
        elseif ($textEntry.Contains("USERNAME:")) {Return "Green"}
	elseif ($textEntry.Contains("COMMAND:")) {Return "Green"}
	elseif ($textEntry.Contains("REPO:")) {Return "Green"}
        else {Return "Yellow"}
    }
}

get-content -wait $textFile | ForEach {Write-Host -ForegroundColor (Get-textColor $_) $_}
# Above borrowed and modified from https://stackoverflow.com/questions/6132140/colour-coding-get-content-results

PAUSE
