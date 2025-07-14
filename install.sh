#!/bin/bash
# MonitorMV Installation Script
# Part of the Mea Vita AI Development Suite

echo "🚀 MonitorMV Installer"
echo "====================" 
echo "Universal AI Usage Monitor"
echo "Part of Mea Vita AI Development Suite"
echo ""

# Check if running on macOS or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "✓ Detected macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "✓ Detected Linux"
else
    echo "⚠️  Warning: Untested OS. Proceeding anyway..."
fi

# Check for Python 3
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    echo "   Please install Python 3.6 or higher and try again."
    exit 1
fi

PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "✓ Python $PYTHON_VERSION found"

# Check for Claude directory
if [ ! -d "$HOME/.claude/projects" ]; then
    echo "⚠️  Warning: Claude directory not found at ~/.claude/projects"
    echo "   Make sure Claude Desktop is installed and you've used it at least once."
fi

# Download if not local
if [ ! -f "monitormv" ]; then
    echo ""
    echo "Downloading MonitorMV..."
    curl -fsSL -o monitormv https://raw.githubusercontent.com/casuallearning/MonitorMV/main/monitormv
    if [ $? -ne 0 ]; then
        echo "❌ Failed to download. Please check your internet connection."
        exit 1
    fi
fi

# Make executable
chmod +x monitormv
echo "✓ Made monitormv executable"

# Choose installation location
echo ""
echo "Where would you like to install MonitorMV?"
echo "1. System-wide (requires sudo) - /usr/local/bin"
echo "2. User local - ~/.local/bin"
echo "3. User home bin - ~/bin"
echo "4. Current directory only (no installation)"
echo ""

read -p "Enter choice (1-4) [default: 1]: " install_choice
install_choice=${install_choice:-1}

case $install_choice in
    1)
        # System-wide installation
        echo ""
        echo "Installing to /usr/local/bin (requires sudo)..."
        sudo cp monitormv /usr/local/bin/monitormv
        
        if [ $? -eq 0 ]; then
            echo "✅ Installation complete!"
            INSTALL_PATH="/usr/local/bin"
            COMMAND="monitormv"
        else
            echo "❌ Installation failed. Try option 2 or 3 for user-local installation."
            exit 1
        fi
        ;;
        
    2)
        # User local installation (~/.local/bin)
        mkdir -p ~/.local/bin
        cp monitormv ~/.local/bin/
        chmod +x ~/.local/bin/monitormv
        
        echo "✅ Installation complete!"
        INSTALL_PATH="~/.local/bin"
        COMMAND="monitormv"
        
        # Check if ~/.local/bin is in PATH
        if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
            echo ""
            echo "⚠️  Note: ~/.local/bin is not in your PATH"
            echo "Add this line to your ~/.bashrc or ~/.zshrc:"
            echo '  export PATH="$HOME/.local/bin:$PATH"'
            echo ""
            echo "Or run directly: ~/.local/bin/monitormv"
        fi
        ;;
        
    3)
        # User home bin installation (~/bin)
        mkdir -p ~/bin
        cp monitormv ~/bin/
        chmod +x ~/bin/monitormv
        
        echo "✅ Installation complete!"
        INSTALL_PATH="~/bin"
        COMMAND="monitormv"
        
        # Check if ~/bin is in PATH
        if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
            echo ""
            echo "⚠️  Note: ~/bin is not in your PATH"
            echo "Add this line to your ~/.bashrc or ~/.zshrc:"
            echo '  export PATH="$HOME/bin:$PATH"'
            echo ""
            echo "Or run directly: ~/bin/monitormv"
        fi
        ;;
        
    4)
        # No installation, just use from current directory
        echo ""
        echo "✅ MonitorMV is ready to use from the current directory!"
        INSTALL_PATH="current directory"
        COMMAND="./monitormv"
        ;;
        
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""
echo "Usage:"
echo "  $COMMAND              # Monitor all available AI services"
echo "  $COMMAND --setup      # Run initial setup wizard"
echo "  $COMMAND --claude     # Monitor only Claude"
echo "  $COMMAND --gemini     # Monitor only Gemini"
echo "  $COMMAND --simple     # Simple text mode"
echo "  $COMMAND --once       # Run once and exit"
echo "  $COMMAND --help       # Show all options"
echo ""
echo "Interactive Dashboard Controls:"
echo "  q - Quit"
echo "  r - Refresh immediately"
echo "  Auto-refreshes every 5 seconds"
echo ""

# Install tab completion if possible
echo "Setting up tab completion..."

# Detect shell
if [ -n "$ZSH_VERSION" ]; then
    # Zsh
    COMPLETION_DIR="${HOME}/.zsh/completions"
    mkdir -p "$COMPLETION_DIR"
    cp monitormv-completion.zsh "$COMPLETION_DIR/_monitormv"
    echo "✓ Zsh completion installed to $COMPLETION_DIR"
    echo "  Add to ~/.zshrc if not already present:"
    echo "  fpath=(~/.zsh/completions \$fpath)"
    echo "  autoload -U compinit && compinit"
elif [ -n "$BASH_VERSION" ]; then
    # Bash
    if [ -d "/etc/bash_completion.d" ] && [ -w "/etc/bash_completion.d" ]; then
        sudo cp monitormv-completion.bash /etc/bash_completion.d/monitormv
        echo "✓ Bash completion installed system-wide"
    elif [ -d "${HOME}/.local/share/bash-completion/completions" ]; then
        cp monitormv-completion.bash "${HOME}/.local/share/bash-completion/completions/monitormv"
        echo "✓ Bash completion installed to ~/.local/share/bash-completion/completions"
    else
        echo "ℹ️  To enable bash completion, add to ~/.bashrc:"
        echo "  source $(pwd)/monitormv-completion.bash"
    fi
fi

echo ""
echo "Try it now: $COMMAND"
echo "Tab completion: Type '$COMMAND --' and press TAB"
echo ""
echo "MonitorMV is part of the Mea Vita AI Development Suite"
echo "Follow us for more quality AI tools at github.com/casuallearning!"