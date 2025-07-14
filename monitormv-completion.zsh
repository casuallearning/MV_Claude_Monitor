#compdef monitormv
# Zsh completion for monitormv

_monitormv() {
    local -a options
    options=(
        '--help[Show help message]'
        '--version[Show version information]'
        '--setup[Run initial setup wizard]'
        '--update[Update MonitorMV to the latest version]'
        '--uninstall[Uninstall MonitorMV from your system]'
        '--claude[Monitor only Claude usage]'
        '--gemini[Monitor only Gemini usage]'
        '--simple[Use simple text mode]'
        '--once[Run once and exit]'
        '--plan[Specify subscription plan]:plan:(pro max5 max20 gemini-free gemini-paid)'
    )
    
    _arguments -s $options
}

_monitormv "$@"