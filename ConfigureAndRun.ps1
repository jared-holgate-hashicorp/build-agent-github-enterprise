param($platform = "windows")

$token = $env:GH_RUNNER_TOKEN
$organisation = $env:GH_RUNNER_ORG
$runnerName = $env:GH_RUNNER_NAME

$gitHubUrl = 'https://github.com/{0}' -f $organisation

if($platform -eq "windows")
{
  ./config.cmd --unattended --url $gitHubUrl --token $token --name $runnerName
  ./run.cmd
}
else
{
  $env:RUNNER_ALLOW_RUNASROOT = "1"
  ./config.sh --unattended --url $gitHubUrl --token $token --name $runnerName
  ./run.sh
}
