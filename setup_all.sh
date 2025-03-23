#!/bin/zsh

set -e  # エラーが出たら停止

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Starting full dotfiles setup..."

echo "🔧 Running Git setup..."
/bin/zsh "$BASE_DIR/Git/setup_git.sh"

echo "🛠 Running Tools setup..."
/bin/zsh "$BASE_DIR/Tools/setup_tools.sh"

echo "💻 Running Zsh setup..."
/bin/zsh "$BASE_DIR/Zsh/setup_zsh.sh"

echo "✅ All setups completed successfully!"