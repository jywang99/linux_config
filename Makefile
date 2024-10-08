user:
	mkdir -p ~/.config/tmux/plugins
	stow -t ~/ home

# make WSL resources available in C:\wsl\res
# terminal settings still have to be set manually
wsl:
	mkdir -p /mnt/c/wsl
	cp -r ${PWD}/wsl/ /mnt/c/wsl/res

# for copying configs from one machine to another
tarball:
	tar -czvf dist/tmux_plugins.tar.gz -C ~/.config/tmux/ plugins
	tar -czvf dist/nvim_share.tar.gz -C ~/.local/share/ nvim
	tar --exclude='.git' --exclude='dist/linux_config.tar.gz' -czvf dist/linux_config.tar.gz -C ../ linux_config
	rm dist/tmux_plugins.tar.gz dist/nvim_share.tar.gz

# execute this on the target machine
untar:
	mkdir -p ~/.config/tmux/
	tar -xzvf ./dist/tmux_plugins.tar.gz -C ~/.config/tmux/
	mkdir -p ~/.local/share/
	tar -xzvf ./dist/nvim_share.tar.gz -C ~/.local/share/
	make user

clean:
	rm -rf ./dist/*.tar.gz

