param($platform = "windows")

$WebResponse = Invoke-WebRequest -Uri https://github.com/actions/runner/releases/latest -UseBasicParsing ; 
if($platform -eq "windows")
{
  $filter = "*-win-x64-*"
  $fileName = "actions-runner-latest.zip"
}
else
{
  $filter = "*-linux-x64-*"
  $fileName = "actions-runner-latest.tar.gz"
}

$Link = $WebResponse.Links | Where { $_.href -like $filter } | Select 'href' ; 
$DownloadUrl = 'https://github.com{0}' -f $Link.href ; 

Write-Output "Got Download Url $DownloadUrl. Downloading now..."
$result = Invoke-WebRequest -Uri $DownloadUrl -OutFile $fileName ; 

$currentFolder = Get-Location
Write-Output "Got $fileName. Extracting now..."
if($platform -eq "windows")
{
  $result = Expand-Archive -Path $fileName -DestinationPath $currentFolder ; 
}
else
{
  tar xzf ./$fileName
}

Write-Output "Extracted $fileName. Cleaning up now..."
Remove-Item $fileName -Force ;
Write-Output "All done..."
