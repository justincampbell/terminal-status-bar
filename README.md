# tmux-status-bar [![Build Status](https://travis-ci.org/justincampbell/tmux-status-bar.svg?branch=master)](https://travis-ci.org/justincampbell/tmux-status-bar)

# Installation

## [Homebrew](http://brew.sh)

    brew tap justincampbell/formulae
    brew install tmux-status-bar

## Package

    wget -O tmux-status-bar-latest.tar.gz https://github.com/justincampbell/tmux-status-bar/archive/latest.tar.gz tmux-status-bar
    tar -zxvf tmux-status-bar-latest.tar.gz
    cd tmux-status-bar-latest/
    make install

# Usage

     $ tmux-status-bar -p
     ~3:31 🔋
     $ tmux-status-bar -n
     📶
     $ tmux-status-bar -pn
     ~3:31 🔋  📶

Put your desired command in your tmux `status-right`:

    # ~/.tmux.conf
    set -g status-right '#(tmux-status-bar -pn)'
