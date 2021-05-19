SHELL [ "powershell" ]

FROM mcr.microsoft.com/windows/servercore

RUN mkdir actions-runner; cd actions-runner

WORKDIR /actions-runner

RUN  $WebResponse = Invoke-WebRequest -Uri https://github.com/actions/runner/releases/latest -UseBasicParsing; \
$Link = $WebResponse.Links | Where { $_.href -like "*-win-x64-*" }  | Select href; \
$DownloadUrl = "https://github.com$($Link.href)"; \
Invoke-WebRequest -Uri $DownloadUrl -OutFile actions-runner-win-x64-latest.zip; \
Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-latest.zip", "$PWD"); \
Remove-Item actions-runner-win-x64-latest.zip -Force

CMD $token = $env:GH_RUNNER_TOKEN; \
if($token -eq $null) \
{ \
    Write-Output "Token Missing!"; \
} \
$organisation = $env:GH_RUNNER_ORG; \
if($organisation -eq $null) \
{ \
    Write-Output "Organisation Missing!"; \
} \
./config.cmd --unattended --url https://github.com/$organisation --token $token \
./run.cmd
