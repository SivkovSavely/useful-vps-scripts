#! /usr/bin/bash

GITHUB_RUNNER_VERSION='2.319.1'
GITHUB_RUNNER_TAR_GZ_FILENAME="actions-runner-linux-x64-$GITHUB_RUNNER_VERSION.tar.gz"

if [[ -z "$HOME" ]]
then
  echo HOME env is empty
  exit 3
fi

if [[ "$1" == "" ]]
then
  echo Provide runner name as an argument
  exit 1
fi

if [[ -d "$HOME/github-actions-runners/actions-runner-$1" ]]
then
  echo Runner with name '"'$1'"' already exists!
  exit 2
fi

if [[ ! -f "$HOME/github-actions-runners/$GITHUB_RUNNER_TAR_GZ_FILENAME" ]]
then
  echo Runner image is not downloaded, downloading...
  mkdir -p "github-actions-runners"
  curl -o "$HOME/github-actions-runners/$GITHUB_RUNNER_TAR_GZ_FILENAME" -L https://github.com/actions/runner/releases/download/v$GITHUB_RUNNER_VERSION/$GITHUB_RUNNER_TAR_GZ_FILENAME
fi

echo Setting up a GitHub Actions runner in $HOME/github-actions-runners/actions-runner-$1

set -e

cd $HOME

mkdir -p "github-actions-runners"
cd "github-actions-runners"

mkdir -p "actions-runner-$1"
echo "Unpacking runner archive into $HOME/github-actions-runners/actions-runner-$1"
tar -xzf "$GITHUB_RUNNER_TAR_GZ_FILENAME" -C "actions-runner-$1"
cd "actions-runner-$1"

echo -e "RUNNER_ALLOW_RUNASROOT=1\n$(cat ./config.sh)" > ./config.sh

echo -n "Enter github repo url: "
read -r GITHUB_REPO_URL

echo -n "Enter token: "
read -r GITHUB_RUNNER_TOKEN

echo "Running ./config.sh --url $GITHUB_REPO_URL --token $GITHUB_RUNNER_TOKEN"
./config.sh --url $GITHUB_REPO_URL --token $GITHUB_RUNNER_TOKEN

echo "Running sudo ./svc.sh install"
sudo ./svc.sh install

echo "Running sudo ./svc.sh start"
sudo ./svc.sh start