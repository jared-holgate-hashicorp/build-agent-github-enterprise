# escape=`

FROM mcr.microsoft.com/windows/servercore:latest

ADD runner-setup.ps1 C:/runner-setup.ps1

WORKDIR /actions-runner

SHELL [ "powershell" ]

RUN "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force; `
    iwr -useb get.scoop.sh | iex; `
    scoop install git"

ADD runner.ps1 C:/runner.ps1
CMD C:/runner.ps1
