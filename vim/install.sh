#!/bin/bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

DIR="$( cd "$( dirname "$0" )" && pwd)"
cd bundle/powerline-fonts
./install.sh

cd $DIR

#cd bundle/YouCompleteMe
#./install.sh --clang-completer
