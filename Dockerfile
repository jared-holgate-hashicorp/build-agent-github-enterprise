SHELL [ "powershell" ]

FROM mcr.microsoft.com/windows/servercore:latest

CMD mkdir actions-runner; cd actions-runner

WORKDIR /actions-runner

CMD Invoke-WebRequest -Uri https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-2.278.0.zip -OutFile actions-runner-win-x64-2.278.0.zip

CMD Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-2.278.0.zip", "$PWD")

CMD ./config.cmd --url https://github.com/MaplesGroup --token AAMJTKBOUM545ADOIOLA2PDAUPRRW

RUN ./run.cmd
