FROM mcr.microsoft.com/windows/servercore:ltsc2019

WORKDIR /actions-runner

RUN powershell -Command \
    $WebResponse = Invoke-WebRequest -Uri https://github.com/actions/runner/releases/latest -UseBasicParsing; \
    $Link = $WebResponse.Links | Where { $_.href -like "*-win-x64-*" }  | Select href; \
    $DownloadUrl = "https://github.com$($Link.href)"; \
    Invoke-WebRequest -Uri $DownloadUrl -OutFile actions-runner-win-x64-latest.zip; \
    Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-latest.zip", "$PWD"); \
    Remove-Item actions-runner-win-x64-latest.zip -Force

CMD powershell -Command \
    $token = $env:GH_RUNNER_TOKEN; \
    $organisation = $env:GH_RUNNER_ORG; \
    ./config.cmd --unattended --url https://github.com/$organisation --token $token; \
    ./run.cmd
