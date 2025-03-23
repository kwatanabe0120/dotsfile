#!/bin/zsh

set -e

echo "🔧 Setting up Git aliases and Visual Studio Code as the default editor..."

# Common Git aliases and editor settings
git config --global alias.st status
git config --global alias.co commit
git config --global alias.br branch
git config --global alias.ch checkout
git config --global alias.sw switch
git config --global core.editor "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code --wait"

# Show message for manual user config
echo ""
echo "⚠️ User information is not included in this script."
echo "Please set it manually with the following commands:"
echo ""
echo "  git config --global user.name \"Your Name\""
echo "  git config --global user.email \"you@example.com\""
echo ""
echo "✅ Git Setup complete!"