#!/bin/bash
set -e

# sudo keep-alive, see https://gist.github.com/cowboy/3118588
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

function checking() {
  echo "[Checking $1]"
}

function already_installed() {
  echo "    => already installed"
}

function installing() {
  echo "[Installing $1]"
}

checking "XCode CLI"
xcode-select --install 2>/dev/null || already_installed

checking "Homebrew"
if [ -f /opt/homebrew/bin/brew ]; then
  already_installed
else
  installing "Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew tap Homebrew/bundle
brew update
brew bundle
brew upgrade
brew cu --all --yes --cleanup
brew cleanup -s
