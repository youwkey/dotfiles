#!/bin/bash
set -eu

BASE="$HOME/.dotfiles"

# Setup git-delta
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global delta.syntax-theme "OneHalfDark"
git config --global delta.features "decorations"

# Setup Git global ignores
git config --global core.excludesFile "$BASE/git/gitignore_global"

# (Optional) Setup git hooks
git config --global core.hooksPath "$BASE/git/hooks"

# Setup Directory and SymbolicLink
XDG_CONFIG_HOME=$(grep 'export XDG_CONFIG_HOME=' "$BASE/zsh/sync/env.zsh" | awk -F= '{print $NF}')
XDG_CACHE_HOME=$(grep 'export XDG_CACHE_HOME=' "$BASE/zsh/sync/env.zsh" | awk -F= '{print $NF}')
# Expand ~ to $HOME
XDG_CONFIG_HOME="${XDG_CONFIG_HOME/#\~/$HOME}"
XDG_CACHE_HOME="${XDG_CACHE_HOME/#\~/$HOME}"

mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME"
mkdir -p "$XDG_CACHE_HOME/vim/backup" "$XDG_CACHE_HOME/vim/undo"
mkdir -p "$XDG_CONFIG_HOME/lazygit"
ln -sfn "$BASE/zprofile" "$HOME/.zprofile"
ln -sfn "$BASE/zshrc" "$HOME/.zshrc"
ln -sfn "$BASE/zsh" "$XDG_CONFIG_HOME/sheldon"
ln -sfn "$BASE/zsh/p10k.zsh" "$HOME/.p10k.zsh"
ln -sfn "$BASE/vimrc" "$HOME/.vimrc"
ln -sfn "$BASE/vim" "$HOME/.vim"
ln -sfn "$BASE/lazygit/config.yml" "$XDG_CONFIG_HOME/lazygit/config.yml"
ln -sfn "$BASE/wezterm" "$XDG_CONFIG_HOME/wezterm"
ln -sfn "$BASE/zed" "$XDG_CONFIG_HOME/zed"
ln -sfn "$BASE/yazi" "$XDG_CONFIG_HOME/yazi"

# Setup mise
mise use --global go@latest
mise use --global node@latest
mise use --global python@latest
mise use --global ruby@latest
mise use --global terraform@latest

echo "Done! Run 'p10k configure' to setup Powerlevel10k."
