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

