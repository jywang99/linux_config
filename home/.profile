# Go
if command -v go &> /dev/null; then
    goBinPath=$(go env GOPATH)/bin
    export PATH=$PATH:$goBinPath
fi

# Python
PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    export PYENV_ROOT
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

