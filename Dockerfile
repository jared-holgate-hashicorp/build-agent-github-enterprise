FROM mcr.microsoft.com/windows/servercore:ltsc2019

WORKDIR /actions-runner

RUN powershell -Command " \
    $WebResponse = Invoke-WebRequest -Uri https://github.com/actions/runner/releases/latest -UseBasicParsing ; \
    $Link = $WebResponse.Links | Where { $_.href -like '*-win-x64-*' } | Select 'href' ; \
    $DownloadUrl = 'https://github.com{0}' -f $Link.href ; \
    Invoke-WebRequest -Uri $DownloadUrl -OutFile actions-runner-win-x64-latest.zip ; \
    Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory('{0}/actions-runner-win-x64-latest.zip' -f $PWD, $PWD) ; \
    Remove-Item actions-runner-win-x64-latest.zip -Force ; \
    "

COPY ConfigureAndRun.ps1 ConfigureAndRun.ps1

ENTRYPOINT ["powershell"]
CMD ["ConfigureAndRun.ps1"]

