if ! command -v wl-copy &> /dev/null; then
    return
fi

function wlc() {
    local arg="$1"
    if [[ -z "$arg" ]]; then
        arg=-2
    fi

    if ! [[ "$arg" =~ ^-?[0-9]+$ ]]; then
        echo "Usage: wlc [index]"
        echo "Copy the command from the history at the specified index to the clipboard."
        echo "index: negative = relative to the end of history, positive = absolute index"
        echo "    Default: -2 (last command except wlc)"
        return 1
    fi

    local cmd=$(fc -ln "$arg" | head -1 | xargs | tr -d "\n")
    echo $cmd
    if [[ -n "$cmd" ]]; then
        echo -n "$cmd" | wl-copy
    else
        echo "No command found for index $arg"
        return 1
    fi
}

