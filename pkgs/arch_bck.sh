#!/bin/bash

if [ -n "$1" ]; then
    profile=${1}
fi

pacman -Qqen > arch_${profile}_pkglist-repo.txt
pacman -Qqem > arch_${profile}_pkglist-aur.txt

