param($platformm = "windows")

$WebResponse = Invoke-WebRequest -Uri https://github.com/actions/runner/releases/latest -UseBasicParsing ; 
$filter = $platform -eq "windows" ? "*-win-x64-*" : "*-linux-x64-*" ;
$Link = $WebResponse.Links | Where { $_.href -like $filter } | Select 'href' ; 
$DownloadUrl = 'https://github.com{0}' -f $Link.href ; 
Write-Output "Got Download Url $DownloadUrl. Downloading now..."
$result = Invoke-WebRequest -Uri $DownloadUrl -OutFile actions-runner--latest.zip ; 
$currentFolder = Get-Location
Write-Output "Got actions-runner-latest.zip. Extracting now..."
$result = Expand-Archive -Path actions-runner-latest.zip -DestinationPath $currentFolder ; 
Write-Output "Extracted actions-runner-latest.zip. Cleaning up now..."
Remove-Item actions-runner-latest.zip -Force ;
Write-Output "All done..."
