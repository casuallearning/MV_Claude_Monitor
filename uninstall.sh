#!/bin/bash
# MonitorMV Manual Uninstaller

echo "🗑️  MonitorMV Manual Uninstaller"
echo "================================"
echo ""

# Check where monitormv is installed
INSTALL_PATH=$(which monitormv 2>/dev/null)

if [ -z "$INSTALL_PATH" ]; then
    echo "MonitorMV is not installed in PATH"
    echo ""
    echo "Checking common locations..."
    for path in /usr/local/bin/monitormv ~/.local/bin/monitormv ~/bin/monitormv; do
        if [ -f "$path" ]; then
            INSTALL_PATH="$path"
            echo "Found at: $path"
            break
        fi
    done
fi

if [ -z "$INSTALL_PATH" ]; then
    echo "MonitorMV not found. It may already be uninstalled."
    exit 0
fi

echo ""
echo "This will remove:"
echo "  • $INSTALL_PATH"
echo "  • ~/.monitormv config directory"
echo "  • Tab completion files"
echo "  • Shell configuration entries"
echo ""

read -p "Continue? (y/N): " confirm
if [[ "$confirm" != "y" ]]; then
    echo "Cancelled."
    exit 0
fi

# Remove binary
if [ -n "$INSTALL_PATH" ]; then
    # Check if we need sudo
    if [[ "$INSTALL_PATH" == "/usr/local/bin/"* ]] || [[ "$INSTALL_PATH" == "/usr/bin/"* ]]; then
        echo "Removing $INSTALL_PATH (requires sudo)..."
        sudo rm "$INSTALL_PATH" && echo "✓ Removed binary"
    else
        echo "Removing $INSTALL_PATH..."
        rm "$INSTALL_PATH" && echo "✓ Removed binary"
    fi
fi

# Remove config
if [ -d "$HOME/.monitormv" ]; then
    echo "Removing config directory..."
    rm -rf "$HOME/.monitormv" && echo "✓ Removed config"
fi

# Remove completions
if [ -f "$HOME/.zsh/completions/_monitormv" ]; then
    rm "$HOME/.zsh/completions/_monitormv" && echo "✓ Removed zsh completion"
fi

if [ -f "$HOME/.local/share/bash-completion/completions/monitormv" ]; then
    rm "$HOME/.local/share/bash-completion/completions/monitormv" && echo "✓ Removed bash completion"
fi

if [ -f "/etc/bash_completion.d/monitormv" ]; then
    sudo rm "/etc/bash_completion.d/monitormv" && echo "✓ Removed system bash completion"
fi

# Clean shell configurations
echo "Cleaning shell configurations..."

# Clean .bashrc
if [ -f "$HOME/.bashrc" ]; then
    if grep -q "monitormv" "$HOME/.bashrc" 2>/dev/null; then
        # Create backup
        cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
        # Remove MonitorMV lines
        sed -i.tmp '/# MonitorMV completion/,+2d' "$HOME/.bashrc" 2>/dev/null || \
        sed -i '' '/# MonitorMV completion/,+2d' "$HOME/.bashrc" 2>/dev/null
        sed -i.tmp '/monitormv-completion.bash/d' "$HOME/.bashrc" 2>/dev/null || \
        sed -i '' '/monitormv-completion.bash/d' "$HOME/.bashrc" 2>/dev/null
        rm -f "$HOME/.bashrc.tmp"
        echo "✓ Cleaned ~/.bashrc"
    fi
fi

# Clean .zshrc
if [ -f "$HOME/.zshrc" ]; then
    if grep -q "monitormv" "$HOME/.zshrc" 2>/dev/null || grep -q "MonitorMV" "$HOME/.zshrc" 2>/dev/null; then
        # Create backup
        cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
        # Remove MonitorMV lines
        sed -i.tmp '/# MonitorMV completion/,+2d' "$HOME/.zshrc" 2>/dev/null || \
        sed -i '' '/# MonitorMV completion/,+2d' "$HOME/.zshrc" 2>/dev/null
        rm -f "$HOME/.zshrc.tmp"
        echo "✓ Cleaned ~/.zshrc"
    fi
fi

echo ""
echo "✅ MonitorMV has been uninstalled!"
echo ""
echo "💡 Please restart your terminal or run:"
echo "   source ~/.bashrc  # for bash"
echo "   source ~/.zshrc   # for zsh"
echo ""
echo "You can now test a fresh installation by running:"
echo "  ./install.sh"