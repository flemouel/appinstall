#!/bin/bash

echo "Sudo activation"
sudo -v
while true; do sudo -n true; sleep 20; kill -0 "$$" || exit; done 2>/dev/null &

function checking() {
  echo "[🔍 Checking $1]"
}

function already_installed() {
  echo "    ✅ Already installed"
}

function installing() {
  echo "[⬇️  Installing $1]"
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

echo "[🔄 Updating Homebrew]"
brew update || { echo "❌ brew update failed"; exit 1; }

echo "[📦 Running brew bundle]"
brew bundle || echo "⚠️  brew bundle failed, continuing..."

echo "[⬆️  Upgrading packages]"
brew upgrade || echo "⚠️  Some upgrades may have failed."

echo "[🧹 Cleaning outdated casks]"
brew cu --all --yes --cleanup || echo "⚠️  brew cu failed, skipping..."

echo "[🧼 Final cleanup]"
brew cleanup -s || echo "⚠️  Cleanup failed"

echo "✅ Script completed (with possible warnings)."
