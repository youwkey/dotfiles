Dot Files
=========

## Setup
```shell
# Setup Repository
git clone https://github.com/youwkey/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles

# (Optional) If you want to disable any formula, comment out in Brewfile
vi Brewfile

# Bundle Brewfile
brew bundle

# Setup Git aliases
git config --global --add include.path $HOME/.dotfiles/git/alias

# Setup Git global ignores
git config --global --add core.excludesFile $HOME/.dotfiles/git/gitignore_global

# (Optional) If you want to setup git hooks
git config --global --add core.hooksPath $HOME/.dotfiles/git/hooks

# Setup Directory and SymbolicLink
BASE=$HOME/.dotfiles
XDG_CONFIG_HOME=$(cat $BASE/zsh/sync/env.zsh | grep 'export XDG_CONFIG_HOME=' | awk -F= '{print $NF}')
XDG_CACHE_HOME=$(cat $BASE/zsh/sync/env.zsh | grep 'export XDG_CACHE_HOME=' | awk -F= '{print $NF}')

mkdir $XDG_CONFIG_HOME $XDG_CACHE_HOME
mkdir -p $XDG_CACHE_HOME/vim/{backup,undo}
ln -sfn $BASE/zshrc $HOME/.zshrc
ln -sfn $BASE/zsh $XDG_CONFIG_HOME/sheldon
ln -sfn $BASE/zsh/p10k.zsh $HOME/.p10k.zsh
ln -sfn $BASE/vimrc $HOME/.vimrc
ln -sfn $BASE/vim $HOME/.vim
ln -sfn $BASE/lf $XDG_CONFIG_HOME/lf
ln -sfn $BASE/lazygit/config.yml $XDG_CONFIG_HOME/lazygit/config.yml

# Setup Anyenv
anyenv install --init

# Install Anyenv Packages
anyenv install goenv
anyenv install nodenv

# configure p10k
p10k configure
```
