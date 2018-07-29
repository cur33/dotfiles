#!/bin/bash

SEP=":"

save_env_var() {
    local line file

    if [[ $# -ne 1 ]]; then
        # No need to save if no args
        return
    fi

    line="export MYGITREPOS=\"$1\""

    # Find bash conf file
    if [[ -f ~/.bashrc ]]; then
        file=~/.bashrc
    else # if it's ~/.bash_profile or doesn't exist
        file=~/.bash_profile
    fi

    # Check whether line is in bash conf
    match="^export MYGITREPOS=.*$"
    numlines=$(grep -sc "$match" $file)

    if [[ -z "$numlines" ]] || [[ $numlines -eq 0 ]]; then
        # Not found, so append line to conf file
        echo "$line" >> $file
        echo "entered if"
    else
        # Found, so edit existing line
        line=${line//\//\\/}
        sed "s/$match/$line/p" $file > $file
        echo "entered else"
    fi

    source $file
}

add_repo() {
    local newval dir

    cd "$1"
    dir="$(pwd -P)"
    cd -

    if [[ $(echo "$MYGITREPOS" | grep -c "$dir") -eq 0 ]]; then
        newval="$MYGITREPOS"
        if [[ -n "$newval" ]]; then
            newval="$newval""$SEP"
        fi
        newval="$newval""$dir"
        save_env_var "$newval"
    fi
}

remove_repo() {
    local newval
    newval=$(echo "$MYGITREPOS" | sed "s/(^|:)$1(:)/\1/")
    if [[ "$newval" != "$MYGITREPOS" ]]; then
        save_env_var "$newval"
    fi
}

list_all_repos() {
    echo "$MYGITREPOS" | sed "s/:/\n/"
}

is_dir() {
    if [[ ! -d "$1" ]]; then
        echo "directory $1 does not exist"
        # retval=1
    else
        echo ""
    fi
}

is_git_dir() {
    local dir res

    dir="$1"
    if [[ ! "$dir" =~ ".*/" ]]; then
        dir="$dir""/"
    fi

    res=$(is_dir "$dir")
    if [[ -n "$res" ]] || [[ ! -d "$dir"".git/" ]]; then
        echo "directory $dir is not a git project directory"
        # retval=1
    else
        echo ""
    fi
}


if [[ $# -eq 0 ]]; then
    list_all_repos
elif [[ $# -eq 1 ]] && [[ -n "$(is_git_dir \"$1\")" ]]; then
    add_repo "$1"
elif [[ $# -eq 2 ]]; then
    arg="$1"
    case "$arg" in
    a)
        arg="add"
        ;;
    r)
        arg="remove"
        ;;
    l)
        arg="list"
        ;;
    esac

    case "$arg" in
    add)
        add_repo "$2"
        ;;
    remove)
        remove_repo "$2"
        ;;
    list)
        list_all_repos
        ;;
    esac
fi
