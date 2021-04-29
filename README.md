Dot Files
=========

## Setup
``` sh
# Setup Repository
git clone https://github.com/ywatanabeznzt/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles

# (Optional) If you want to disable any formula, comment out in Brewfile
vi Brewfile

# Bundle Brewfile
brew bundle

# Setup Directory and SymbolicLink
BASE=$HOME/.dotfiles
XDG_CONFIG_HOME=$(cat $BASE/zshrc | grep 'export XDG_CONFIG_HOME=' | awk -F= '{print $NF}')
XDG_CACHE_HOME=$(cat $BASE/zshrc | grep 'export XDG_CACHE_HOME=' | awk -F= '{print $NF}')

mkdir $XDG_CONFIG_HOME $XDG_CACHE_HOME
mkdir -p $XDG_CACHE_HOME/vim/{backup,undo}
ln -sfn $BASE/zshrc $HOME/.zshrc
ln -sfn $BASE/vimrc $HOME/.vimrc
ln -sfn $BASE/vim $HOME/.vim

# Setup Anyenv
anyenv install --init

# Install Anyenv Packages
anyenv install goenv
anyenv install nodenv
```
