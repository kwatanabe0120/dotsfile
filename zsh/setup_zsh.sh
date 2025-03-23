#!/bin/zsh

# Script to set up the base Zsh environment.
# Does not include individual tool configurations like Flutter Pass.

set -e  # エラー時に停止

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_FILES=(".zshrc" ".p10k.zsh")
TIMESTAMP=$(date +"%Y%m%d_%H%M")

echo "🔧 Starting Zsh setup..."

for file in "${TARGET_FILES[@]}"; do
    src="$DOTFILES_DIR/$file"
    dest="$HOME/$file"

    if [ -e "$dest" ]; then
        echo "⚠️  $file already exists in your home directory."

        # ファイルごとに異なる注意文
        if [ "$file" = ".zshrc" ]; then
            echo "⚠️  Please check the .zshrc file before continuing."
            echo "   It only has a basic setup. If you have added custom configs like Flutter Pass, they are not included."
        fi

        echo -n "❓ Do you want to overwrite $file? (yes/no): "
        read answer
        if [ "$answer" != "yes" ]; then
            echo "⏭️  Skipping $file"
            continue
        fi

        backup="$dest.$TIMESTAMP.backup"
        cp "$dest" "$backup"
        echo "📦 Backed up existing $file to $backup"
    fi

    cp "$src" "$dest"
    echo "✅ Copied $file"
done

echo "🎉 Zsh setup complete!"