#!/bin/bash
NOWs=$(TZ='America/New_York' date +"%m-%d-%Y %H:%M")

adduser --system --disabled-login ghrunner
usermod -aG sudo ghrunner
cd /home/ghrunner

export RUNNER_ALLOW_RUNASROOT="1"
export svc_user="ghrunner"
if [ "null" == "${ghtoken}" -o -z "${ghtoken}" ]; then fatal "Failed to receive the authentication token"; fi

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install jq -y
sudo apt-get install git -y
sudo apt-get install unzip -y
sudo apt-get install zip -y
sudo apt-get update -y

cli_download_url="https://aka.ms/InstallAzureCLIDeb"
curl -sL $cli_download_url | sudo bash
sudo -E -u "ghrunner" mkdir runner

gh_download_url="https://github.com/actions/runner/releases/download/v${runnerversion}/actions-runner-linux-x64-${runnerversion}.tar.gz"
register_url='https://github.com/Azure-Infrastructure/Automation'

sudo -E -u "ghrunner" curl -O -L $gh_download_url
sudo -E -u "ghrunner" tar xzf "./actions-runner-linux-x64-${runnerversion}.tar.gz" -C runner
sudo chown -R "ghrunner" ./runner
cd runner
sudo -E -u "ghrunner" ./bin/installdependencies.sh
sudo -E -u "ghrunner" ./config.sh --unattended --url $register_url --token ${ghtoken} --name ${shrhname} --labels ${shrhname} 

sudo ./svc.sh install "ghrunner"
sudo ./svc.sh start
NOWf=$(TZ='America/New_York' date +"%m-%d-%Y %H:%M")
echo "Start:  $NOWs"
echo "Finish: $NOWf"