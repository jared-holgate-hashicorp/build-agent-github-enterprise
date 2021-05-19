$WebResponse = Invoke-WebRequest -Uri https://github.com/actions/runner/releases/latest -UseBasicParsing ; 
$Link = $WebResponse.Links | Where { $_.href -like '*-win-x64-*' } | Select 'href' ; 
$DownloadUrl = 'https://github.com{0}' -f $Link.href ; 
Write-Output "Got Download Url $DownloadUrl. Downloading now..."
$result = Invoke-WebRequest -Uri $DownloadUrl -OutFile actions-runner-win-x64-latest.zip ; 
$currentFolder = Get-Location
Write-Output "Got actions-runner-win-x64-latest.zip. Extracting now..."
$result = Expand-Archive -Path actions-runner-win-x64-latest.zip -DestinationPath $currentFolder ; 
Write-Output "Extracted actions-runner-win-x64-latest.zip. Cleaning up now..."
Remove-Item actions-runner-win-x64-latest.zip -Force ;
Write-Output "All done..."
