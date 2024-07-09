#!/bin/bash

if [ -n "$1" ]; then
    profile=${1}_
fi

pacman -Qqen > ${profile}pkglist-repo.txt
pacman -Qqem > ${profile}pkglist-aur.txt

