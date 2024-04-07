$logFile = "./howtocomputer.txt"

function Get-LogColor {
    Param([Parameter(Position=0)]
    [String]$LogEntry)

    process {
        if ($LogEntry.Contains("====")) {Return "Blue"}
	elseif ($LogEntry.Contains("++++++")) {Return "Blue"}
        elseif ($LogEntry.Contains("username")) {Return "Green"}
	elseif ($LogEntry.Contains("COMMAND:")) {Return "Green"}
	elseif ($LogEntry.Contains("REPO:")) {Return "Green"}
        else {Return "Yellow"}
    }
}

get-content -wait $logFile | ForEach {Write-Host -ForegroundColor (Get-LogColor $_) $_}
# Above borrowed and modified from https://stackoverflow.com/questions/6132140/colour-coding-get-content-results

PAUSE
