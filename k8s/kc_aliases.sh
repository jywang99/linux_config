#!/bin/bash

# Kubernetes command aliases
alias kls='kc config get-contexts'
alias kns='kc get namespace'

alias kc='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kge='kubectl get events'

alias kd='kubectl describe'
alias kdp='kubectl describe pods'
alias kdd='kubectl describe deployments'
alias kds='kubectl describe services'
alias kdn='kubectl describe nodes'

alias ke='kubectl edit'
alias kep='kubectl edit pod'
alias ked='kubectl edit deployment'
alias kes='kubectl edit service'
alias ken='kubectl edit node'

alias ke='kubectl exec -it'
alias klogs='kubectl logs'

