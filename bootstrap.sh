#!/usr/bin/env bash

# make sure that getopts works while sourcing the script
OPTIND=1

# usage description
usage() {
    cat << EOF
usage: $0 options

This script installs the dotfiles into your home directory.

OPTIONS:
   -h      Show this message
   -u      Update repository
   -f      Force synchronization
EOF
}

# synchronize files to home directory
syncfiles() {
    local backupdir="$HOME/.dotfiles-$(date +%Y%m%d-%H%M%S)"
    [ ! -d "$backupdir" ] && mkdir -p "$backupdir"
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
          --exclude "README.md" --exclude "LICENSE-MIT.txt" -avb --no-perms \
          --backup-dir="$backupdir" . "$HOME"
    [ -e "$HOME/.profile" ] && source "$HOME/.profile"
}

# update the dotfiles repository
updaterepo() {
    git fetch -q origin >/dev/null
    git pull -q origin master >/dev/null
}

OPTFORCED=
while getopts "::hfu" option; do
    case "$option" in
        f)
            OPTFORCED=1
            ;;
        u)
            updaterepo
            ;;
        h)
            usage
            return
            ;;
        \?)
            usage
            return 1
            ;;
    esac
done

if [ -n "$OPTFORCED" ]; then
    syncfiles
else
    read -p "This action may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        syncfiles
    fi
fi
