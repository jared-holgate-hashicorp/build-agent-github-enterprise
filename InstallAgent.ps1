$WebResponse = Invoke-WebRequest -Uri https://github.com/actions/runner/releases/latest -UseBasicParsing ; 
$Link = $WebResponse.Links | Where { $_.href -like '*-win-x64-*' } | Select 'href' ; 
$DownloadUrl = 'https://github.com{0}' -f $Link.href ; 
Invoke-WebRequest -Uri $DownloadUrl -OutFile actions-runner-win-x64-latest.zip ; 
$currentFolder = Get-Location
Expand-Archive -Path actions-runner-win-x64-latest.zip -DestinationPath $currentFolder ; 
Remove-Item actions-runner-win-x64-latest.zip -Force ;
