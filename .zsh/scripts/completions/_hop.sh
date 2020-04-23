#compdef hop
# vim: ft=zsh :

_hop_get_servers_list() {
    IFS=" "
    "$HOME/bin/hop" --list | \
        tr $'\t' ':'
}

_hop() {
    local -a commands

    IFS=$'\n'
    commands=(`_hop_get_servers_list`)

    _describe -t commands 'commands' commands
}

compdef _hop hop
