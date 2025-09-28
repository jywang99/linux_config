# Linux Config
My Linux configuration files and scripts.

## Packages
Required:
```
build-essential git stow nodejs npm
```

Optional (recommended):
```
ripgrep fzf zoxide nodejs tmux vim neovim
```

Optional:
```
starship nvm
```

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
2. [tmux](home/.config/tmux/README.md)

## Coding languages
1. Python (recommended: [pyenv](https://github.com/pyenv/pyenv))
2. [Go](https://go.dev/doc/install) - make sure `go` is executable. `.bashrc` will automatically make `$(go env GOPATH)/bin` available in `PATH`.

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

## Bash completion
Bash completion for `git` and `docker` are enabled by default. To enable other completions, place scripts in `~/.config/bash-completion/` directory. Those scripts are sourced by `~/.bashrc`.

For `kubectl`:
```bash
kubectl completion bash > ~/.config/bash-completion/kubectl
```

