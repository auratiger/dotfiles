#!/bin/bash

# A script to search google with the contents of your clipboard

if [[ $OSTYPE == 'darwin'* ]]; then
    # for Mac
    clip="$(pbpaste | tr " " "+")"
    open -a firefox -g https://google.com/search?q=$clip
else
    # for linux
    clip=$(xclip -o | tr " " "+")
    firefox https://google.com/search?q=$clip
fi
