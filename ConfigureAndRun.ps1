$token = $env:GH_RUNNER_TOKEN
$organisation = $env:GH_RUNNER_ORG
$gitHubUrl = 'https://github.com/{0}' -f $organisation
./config.cmd --unattended --url $gitHubUrl --token $token
./run.cmd
