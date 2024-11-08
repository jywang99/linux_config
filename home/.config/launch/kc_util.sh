#!/bin/bash

alias kc='kubectl'

# Kubernetes command aliases
alias kls='kc config get-contexts'
alias kns='kc get namespace'

alias kga='kubectl get all'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kge='kubectl get events'
alias kgc='kubectl get configmap'

alias kd='kubectl describe'
alias kdp='kubectl describe pods'
alias kdd='kubectl describe deployments'
alias kds='kubectl describe services'
alias kdn='kubectl describe nodes'
alias kdc='kubectl describe configmap'

alias ke='kubectl edit'
alias kep='kubectl edit pod'
alias ked='kubectl edit deployment'
alias kes='kubectl edit service'
alias ken='kubectl edit node'
alias kec='kubectl edit configmap'

alias ke='kubectl exec -it'
alias klogs='kubectl logs'

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

kcdp() {
    local partial_name="$1"
    
    # Get the list of pod names matching the partial name
    local pod_list=$(kubectl get pods --no-headers -o custom-columns=":metadata.name"|grep $partial_name)

    # Count the number of matching pods
    local pod_count=$(echo "$pod_list" | wc -w)

    if [[ $pod_count -eq 0 ]]; then
        echo "No pods found matching the partial name '$partial_name'"
        return 1
    fi
    if [[ $pod_count -gt 1 ]]; then
        echo "Multiple pods found matching the partial name '$partial_name'. Please refine your search."
        return 1
    fi

    # Delete the single matching pod
    kubectl delete pod $(echo "$pod_list")
    echo "Pod deleted successfully."
}

