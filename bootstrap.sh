#!/usr/bin/env bash

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

syncfiles() {
  [ ! -d "$HOME/.dotfiles-backup" ] && mkdir -p "$HOME/.dotfiles-backup"
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "README.md" --exclude "LICENSE-MIT.txt" -avb --no-perms \
        --backup-dir="$HOME/.dotfiles-backup" . "$HOME"
  [ -e "$HOME/.profile" ] && source "$HOME/.profile"
}

updaterepo() {
  git fetch -q origin >/dev/null
  git pull -q origin master >/dev/null
}

optforce=
while getopts "h::fu" option; do
  case "$option" in
    f)
      optforce=1
      ;;
    u)
      updaterepo
      ;;
    h)
      usage
      exit
      ;;
    \?)
      usage
      exit 1
      ;;
  esac
done

if [ -n "$optforce" ]; then
  syncfiles
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    syncfiles
  fi
fi
