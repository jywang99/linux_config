# Linux Configs
My Linux configuration files and scripts.\
Some configs are in submodules.

## Dotfiles
My dotfiles are stored under `home` directory of this repository.\
Steps to apply dotfiles:
1. Install [Stow](https://www.gnu.org/software/stow/)
2. Run make command
```bash
make user
```

## Other configs
These configs need additional steps to apply.
1. [tmux](home/.config/tmux/README.md)
2. [Arch packages](arch/README.md)

### Bash completion
Bash completion for `git` and `docker` are enabled by default. To enable other completions, place scripts in `~/.config/bash-completion/` directory. Those scripts are sourced by `~/.bashrc`.

Example for `kubectl` completion:
```bash
kubectl completion bash > ~/.config/bash-completion/kubectl
```

## Copy configs to new system
For copying configs to a system without internet connection.\
**Prerequisite**: Configs are already applied on the current system.
1. Run make command to generate a tarball
```bash
make tarball
```
2. Copy the tarball to the new system, and extract it
```bash
# Example
scp ./dist/linux_config.tar.gz myhost:~/git
ssh myhost
cd git
tar -xzf linux_config.tar.gz
cd linux_config
```
3. Apply other configs in tarball
```bash
make untar
```

