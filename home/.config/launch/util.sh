if ! command -v zoxide &> /dev/null; then
    return
fi

function zd() {
    # change directory using zoxide and ls
    # Usage: zd [directory]
    # Example: zd ~/Documents

    local target_dir=$1
    if [[ -z "$target_dir" ]]; then
        target_dir=$HOME
    fi

    z "$target_dir" && ls -l
}

function genpass() {
    local length="${1:-24}"
    local symbols="${2:-false}"
    local charset
    
    if [[ "$symbols" == "true" ]]; then
        charset='A-Za-z0-9!@#$%^&*()_+-=[]{}|;:,.<>?'
    else
        charset='A-Za-z0-9'
    fi
    
    tr -dc "$charset" < /dev/urandom | head -c "$length"
}

