```bash
: "
                                   _       _    __ _ _
                                  | |     | |  / _(_) |
                                __| | ___ | |_| |_ _| | ___  ___
                               / _` |/ _ \| __|  _| | |/ _ \/ __|
                              | (_| | (_) | |_| | | | |  __/\__ \
                               \__,_|\___/ \__|_| |_|_|\___||___/
                                --------------------------------
                                Add a dot in front of that file! 
                         ----------------------------------------------

             -----------------------------------------------------------------------
             This repository is the collection of configurations that I learned over
             time and still use for my  daily work. The repository contains  configs
             files for vim, tmux, zsh and much more. Also if you're on windows or
             can't be botherd setting up a new machine, I have created a Dockerfile
             container which can be used as a standalone working environment.
             Enjoy!!
             -----------------------------------------------------------------------
    
"
```

## How to install

Before starting the installation, I recommend reading [Storing dotfiles with Git](https://engineeringwith.kalkayan.io/series/developer-experience/storing-dotfiles-with-git-this-is-the-way/?utm_source=github.com) to understand how this repository makes the best of Git using `--bare`. 

clone the bare repo into a chosen directory on the system, in this case ~/.dotfiles 

`git clone --bare git@github.com:auratiger/dotfiles.git $HOME/.dotfiles`

Set an alias linking the ~/.dotfiles repo to the home directory. In this case it is already set in
zsh-aliases.zsh

`alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"`


use the set `dot` alias from the zsh config to disable untracked files for the bare repo

`dot status.showUntrackedFiles no`

At this point if you do `dot status` it will show all divergences of your home and the repo
dotfiles. Here it's safe to either manually backup all your dotfiles, or just do 

If `dot status.showUntrackedFiles no` gave an error, use `dot su` to show changes without untracked files

`dot stash`

Which will stash the changes and in practicality will override the current files with the dotfiles 

When adding new changes use the `dot alu` to add all changed files ignoring untracked files
