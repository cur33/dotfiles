#!/bin/bash

# TODO
# Add options for -v (verbose), -f (force the symlinks)
# Possibly add option for -u (update if local script newer than existing)

### Functions ###

printsection() {
    printf "\n*** $* ***\n\n"
}

### Vim ###

# printf "\n*** Setting up vim ***\n\n"
printsection Setting up vim config

VIM_DEST=$HOME/.vim
VIMRC_DEST=$HOME/.vimrc

if [[ ! -e "$VIM_DEST" ]]; then
    ln -s "$( pwd )"/.vim $HOME/.vim
else
    echo "$VIM_DEST" already exists
fi

if [[ ! -e "$VIMRC_DEST" ]]; then
    ln -s $HOME/.vim/.vimrc $HOME/.vimrc
else
    echo "$VIMRC_DEST" already exists
fi

printsection Installing vim plugins

git submodule update --init

### Emacs ###

printsection Setting up emacs config

if [[ ! -e "$HOME/.emacs.d" ]]; then
    ln -s "$( pwd )"/.emacs.d $HOME/.emacs.d
else
    echo "$HOME/.emacs.d" already exists
fi

### Shell scripts ###

printsection Setting up shell scripts

SCRIPTS_SRC="$( pwd )"/shell-scripts
SCRIPTS_DEST=/usr/local/bin

if [[ ! -d "$SCRIPTS_DEST" ]]; then
    echo \"$SCRIPTS_DEST\" does not exist
    exit 1
fi

scripts=( $( ls "$SCRIPTS_SRC" ) )
for script in "${scripts[@]}"; do
    if [[ "$script" =~ ([^.]+)\.?(.+)? ]]; then
        exe_name="${BASH_REMATCH[1]}"
        exe_type="${BASH_REMATCH[2]}"
        existing_path="$( which "$exe_name" )"
        srcpath="$SCRIPTS_SRC"/"$script"
        destpath="$SCRIPTS_DEST"/"$exe_name"

        if [[ -z "$existing_path" ]]; then
            chmod +x "$srcpath"
            ln -s "$srcpath" "$destpath"
            echo Symlinked "$srcpath" to "$exe_name"
        else
            echo "$exe_name" already exists at "$existing_path"
        fi
    else
        # This should really never fire
        echo Filename \"$script\" is invalid
    fi
done

echo
