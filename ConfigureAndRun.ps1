param($platformm = "windows")

$token = $env:GH_RUNNER_TOKEN
$organisation = $env:GH_RUNNER_ORG
$gitHubUrl = 'https://github.com/{0}' -f $organisation

if($platform -eq "windows")
{
  ./config.cmd --unattended --url $gitHubUrl --token $token
  ./run.cmd
}
else
{
  export RUNNER_ALLOW_RUNASROOT="1"
  ./config.sh --unattended --url $gitHubUrl --token $token
  ./run.sh
}
