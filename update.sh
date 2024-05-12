#!/usr/bin/bash

rm -rf $HOME/.cpfixer
mkdir -p $HOME/.cpfixer
git clone -b exec "https://github.com/ArthurSpeziali/CpFixer" $HOME/.cpfixer
cd $HOME/.cpfixer
mix escript.build
