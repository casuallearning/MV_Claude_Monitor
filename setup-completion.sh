#!/bin/bash
# Setup tab completion for MonitorMV

echo "🔧 Setting up MonitorMV tab completion..."

# Detect current shell
if [ -n "$ZSH_VERSION" ]; then
    echo "Detected: Zsh"
    
    # Create completions directory
    COMPLETION_DIR="${HOME}/.zsh/completions"
    mkdir -p "$COMPLETION_DIR"
    
    # Copy completion file
    cp monitormv-completion.zsh "$COMPLETION_DIR/_monitormv"
    
    # Check if fpath is set up in .zshrc
    if ! grep -q "fpath.*\.zsh/completions" ~/.zshrc 2>/dev/null; then
        echo "" >> ~/.zshrc
        echo "# MonitorMV completion" >> ~/.zshrc
        echo "fpath=(~/.zsh/completions \$fpath)" >> ~/.zshrc
        echo "autoload -U compinit && compinit" >> ~/.zshrc
        echo "✅ Added completion setup to ~/.zshrc"
    else
        echo "✅ Completion directory already in fpath"
    fi
    
    echo ""
    echo "To enable completion in current session, run:"
    echo "  source ~/.zshrc"
    
elif [ -n "$BASH_VERSION" ]; then
    echo "Detected: Bash"
    
    # Try different locations
    if [ -d "${HOME}/.local/share/bash-completion/completions" ]; then
        mkdir -p "${HOME}/.local/share/bash-completion/completions"
        cp monitormv-completion.bash "${HOME}/.local/share/bash-completion/completions/monitormv"
        echo "✅ Installed to ~/.local/share/bash-completion/completions"
    else
        # Add to .bashrc
        if ! grep -q "monitormv-completion.bash" ~/.bashrc 2>/dev/null; then
            echo "" >> ~/.bashrc
            echo "# MonitorMV completion" >> ~/.bashrc
            echo "[ -f $(pwd)/monitormv-completion.bash ] && source $(pwd)/monitormv-completion.bash" >> ~/.bashrc
            echo "✅ Added completion to ~/.bashrc"
        else
            echo "✅ Completion already set up in ~/.bashrc"
        fi
    fi
    
    echo ""
    echo "To enable completion in current session, run:"
    echo "  source ~/.bashrc"
else
    echo "⚠️  Unknown shell. Manual setup required."
    echo ""
    echo "For Zsh, add to ~/.zshrc:"
    echo "  source $(pwd)/monitormv-completion.zsh"
    echo ""
    echo "For Bash, add to ~/.bashrc:"
    echo "  source $(pwd)/monitormv-completion.bash"
fi

echo ""
echo "Test with: monitormv --[TAB]"