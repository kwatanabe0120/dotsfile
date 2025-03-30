#!/bin/zsh

# ----------------------------------------------------------------------------
# 🛠 Script to set up the base Zsh environment
# ----------------------------------------------------------------------------
# - Migrates existing ~/.zshrc content (with confirmation) to ~/.zshrc.local
# - Skips any content already present in the Git-managed .zshrc or local
# - Avoids infinite source loop of .zshrc.local
# - Creates a timestamped backup of any existing .zshrc
# - Links ~/.zshrc to your Git-managed dotfiles version
# - Adds helpful messages and reloads the config
# ----------------------------------------------------------------------------

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSHRC_TARGET="$DOTFILES_DIR/.zshrc"
ZSHRC_LINK="$HOME/.zshrc"
ZSHRC_LOCAL="$HOME/.zshrc.local"
TIMESTAMP=$(date +"%Y%m%d_%H%M")

# -------------------------
# 🧭 Guide for the user
# -------------------------
echo ""
echo "🛠 Zsh Environment Setup"
echo "────────────────────────────"
echo "This script will do the following:"
echo "1. Backup your existing ~/.zshrc to ~/.zshrc.$TIMESTAMP.backup"
echo "2. Migrate unique, local-only settings into ~/.zshrc.local (PC-specific)"
echo "3. Create a symlink: ~/.zshrc -> $ZSHRC_TARGET"
echo "4. Ensure no duplicate or looping content"
echo "5. Reload your Zsh configuration"
echo ""
echo "ℹ️  Notes:"
echo "- The Git-managed .zshrc will automatically load ~/.zshrc.local at the end."
echo "- Use ~/.zshrc.local for local settings (e.g., Flutter PATH, aliases)."
echo "- Never edit ~/.zshrc directly — edit the Git-managed version instead."
echo ""
echo "🚀 After initial setup, you can just run 'git pull' to sync shared configs."
echo "   Local configs in ~/.zshrc.local will remain untouched."
echo ""
echo -n "❓ Do you want to proceed? (yes/no): "
read proceed
if [ "$proceed" != "yes" ]; then
  echo "❌ Aborted by user."
  exit 0
fi

# -------------------------
# 🔄 Migrate existing ~/.zshrc
# -------------------------
if [ -f "$ZSHRC_LINK" ] || [ -L "$ZSHRC_LINK" ]; then
echo "\n⚠️  Existing ~/.zshrc detected."
echo "ℹ️  Before proceeding, a backup of your current ~/.zshrc will be created to ensure safety."
echo -n "❓ Migrate its unique content to ~/.zshrc.local and overwrite with symlink? (yes/no): "
read migrate

if [ "$migrate" = "yes" ]; then
	backup="$ZSHRC_LINK.$TIMESTAMP.backup"
	cp "$ZSHRC_LINK" "$backup"
	echo "📦 Backed up to: $backup"
	echo "ℹ️  A backup of your original ~/.zshrc has been saved as $backup."

	if [ ! -f "$ZSHRC_LOCAL" ]; then
		touch "$ZSHRC_LOCAL"
	fi

    echo "\n# ===== Migrated from previous .zshrc on $TIMESTAMP =====\n" >> "$ZSHRC_LOCAL"

    # Copy only lines not found in the Git-managed .zshrc or already in local
    while IFS= read -r line; do
      # Skip dangerous self-includes
      if [[ "$line" == *"source ~/.zshrc.local"* ]]; then
        continue
      fi
      # Skip if already in Git-managed .zshrc
      if grep -Fxq "$line" "$ZSHRC_TARGET"; then
        continue
      fi
      # Skip if already in .zshrc.local
      if grep -Fxq "$line" "$ZSHRC_LOCAL"; then
        continue
      fi
      echo "$line" >> "$ZSHRC_LOCAL"
    done < "$ZSHRC_LINK"

    rm -f "$ZSHRC_LINK"
    echo "✅ Clean migration complete."
  else
    echo "⏭️  Skipping migration."
    exit 0
  fi
fi

# -------------------------
# 🔗 Create symlink to Git-managed .zshrc
# -------------------------
ln -sf "$ZSHRC_TARGET" "$ZSHRC_LINK"
echo "✅ Symlink created: ~/.zshrc -> $ZSHRC_TARGET"

# -------------------------
# 🧾 Create ~/.zshrc.local if missing
# -------------------------
if [ ! -f "$ZSHRC_LOCAL" ]; then
  echo "📝 Creating empty ~/.zshrc.local"
  cat <<EOF > "$ZSHRC_LOCAL"
# Local machine-specific Zsh settings go here
# e.g., export PATH=\"\$PATH:/your/custom/path\"
EOF
else
  echo "📄 ~/.zshrc.local already exists. It was preserved as-is."
fi

# -------------------------
# ✅ Done! Reload config
# -------------------------
echo ""
echo "🎉 Zsh setup complete!"
echo "────────────────────────────"
echo "🔗 ~/.zshrc is now linked to: $ZSHRC_TARGET"
echo "⚙️  ~/.zshrc.local will be sourced automatically"
echo "   Use it for PC-specific settings only."
echo ""
echo "♻️  Reloading your Zsh configuration..."
source ~/.zshrc

echo "✅ All done. You're ready to Zsh! ✨"
