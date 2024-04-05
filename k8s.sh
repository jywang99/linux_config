kcns() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: switch_namespace <namespace_name>"
        return 1
    fi

    namespace_name="$1"
    kubectl config set-context --current --namespace="${namespace_name}"
    echo "Switched to namespace: ${namespace_name}"
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
