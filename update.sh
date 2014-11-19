#!/bin/bash

echo " [>] Updating submodules"
git submodule foreach git pull origin master:master
git submodule foreach git submodule update --force --init --recursive
echo " [>] Building YouCompleteMe"
cd ./vim/vim/bundle/YouCompleteMe/
./install.sh --clang-completer --system-libclang
cd $STUFF/vim/vim/bundle/tern_for_vim/
npm install
