#!/bin/bash
# Bash completion for monitormv

_monitormv_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # All available options
    opts="--help --version --setup --update --uninstall --claude --gemini --simple --once --plan"
    
    # Handle --plan argument values
    if [[ ${prev} == "--plan" ]] ; then
        COMPREPLY=( $(compgen -W "pro max5 max20 gemini-free gemini-paid" -- ${cur}) )
        return 0
    fi
    
    # Handle options
    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}

complete -F _monitormv_completion monitormv