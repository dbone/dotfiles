#!/bin/sh

mkdir ~/.config
mkdir ~/.config/ghostty
mkdir ~/.config/nvim

echo "Install tmux plugin manager..."
mkdir .tmux
stow tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
