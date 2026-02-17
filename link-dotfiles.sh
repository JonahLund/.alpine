#!/bin/sh

DIR=$( dirname -- "$( readlink -f -- "$0"; )"; )
DOTFILES="$DIR/dotfiles"

ln -sf "$DOTFILES/.profile" "$DOTFILES/.gitconfig" "$HOME"
ln -sf "$DOTFILES/foot" \
  "$DOTFILES/helix" \
  "$DOTFILES/sway" \
  "$DOTFILES/fontconfig" \
  "$DOTFILES/gtk-3.0" \
  "$DOTFILES/workstyle" \
  "$DOTFILES/tmux" \
  "$HOME/.config"
