#!/bin/bash

echo "[🧹 Running brew bundle cleanup --force]"
brew bundle cleanup --force || echo "⚠️  brew bundle cleanup failed"

echo "✅ Script completed (with possible warnings)."
