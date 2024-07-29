user:
	mkdir -p ~/.config/tmux/plugins
	stow -t ~/ home

# make WSL resources available in C:\wsl\res
# terminal settings still have to be set manually
wsl:
	mkdir -p /mnt/c/wsl
	cp -r ${PWD}/wsl/ /mnt/c/wsl/res

