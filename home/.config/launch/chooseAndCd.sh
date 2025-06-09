export FAV_DIRS=

convert_colon_list_to_array() {
    local colon_list=$1
    local IFS=':'
    read -ra arr <<< "$colon_list"
    echo "${arr[@]}"
}

function execute() {
    local cmd=$1
    local target=$2
    echo "$cmd $target"
    eval $cmd $target
}

function goto() {
    if [ -z $FAV_DIRS ]; then
        echo "No favorite directories found."
        return
    fi

    PS3='Go to: '
    local options=($(convert_colon_list_to_array $FAV_DIRS))
    local cmd=${GOTO_CMD:-cd}

    re='^[0-9]+$'
    if [[ $1 =~ $re ]] ; then
        tdir=${options[$(($1-1))]}
        if [ ! -d $tdir ]; then
            echo "Directory does not exist."
        else
            execute $cmd $tdir
            return
        fi
    fi

    select opt in "${options[@]}"
    do
        if [ -z "$opt" ]; then
            echo "Invalid option."
        elif [ ! -d $opt ]; then
            echo "Directory does not exist."
        else
            execute $cmd $opt
            break
        fi
    done
}
export -f goto

