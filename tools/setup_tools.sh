#!/bin/zsh

set -e  # Stop on error

echo "🍺 Setting up Homebrew..."

# Install Homebrew
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "✅ Homebrew is already installed"
fi

# Install CocoaPods (via gem)
if ! command -v pod &>/dev/null; then
	echo "Setting up CocoaPods..."
	sudo gem install cocoapods
else
	echo "✅ CocoaPods is already installed"
fi

echo "🎉 Homebrew & CocoaPods setup complete!"