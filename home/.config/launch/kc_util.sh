#!/bin/bash

alias k='kubectl'

# Kubernetes command aliases
alias kls='k config get-contexts'
alias kns='k get namespace'

alias kgp='k get pods'
alias kgd='k get deployments'
alias kgs='k get services'
alias kgn='k get nodes'
alias kge='k get events'
alias kgc='k get configmap'

alias kd='k describe'
alias kdp='k describe pods'
alias kdd='k describe deployments'
alias kds='k describe services'
alias kdn='k describe nodes'
alias kdc='k describe configmap'

alias ke='k edit'
alias kep='k edit pod'
alias ked='k edit deployment'
alias kes='k edit service'
alias ken='k edit node'
alias kec='k edit configmap'

alias ke='k exec -it'
alias klogs='k logs'

kcs() {
    # Check if namespace argument is provided
    if [ -z "$1" ]; then
        echo "Namespace argument is mandatory"
        return 1
    fi
    
    # Optional: Check if cluster argument is provided, if not, use the current context
    if [ -n "$2" ]; then
        kubectl config use-context "$2" || return 1
    fi

    # Set the namespace
    kubectl config set-context --current --namespace="$1" || return 1

    echo "Switched to namespace '$1'"

    return 0
}
_kcs_completion() {
    local curr_arg prev_arg
    curr_arg="${COMP_WORDS[COMP_CWORD]}"
    prev_arg="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$(kubectl get ns -o jsonpath='{.items[*].metadata.name}')" -- "$curr_arg") )
    elif [[ $COMP_CWORD -eq 2 ]]; then
        COMPREPLY=( $(compgen -W "$(kubectl config get-contexts -o name)" -- "$curr_arg") )
    fi
}
complete -F _kcs_completion kcs

