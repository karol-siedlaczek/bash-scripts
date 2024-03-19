#!/bin/bash

REPOSITORY=$2
DIRECTORY=$3
BRANCH=$4

function show_usage() {
    echo -e "Usage: git-clone {gerrit|github} <repository> <directory> [<branch>|main]" >&2
    exit 1
}

case "$1" in
    gerrit)
        CMD=ssh://karol.siedlaczek@git.atendesoftware.pl:29418/$REPOSITORY
        if [[ -z $BRANCH ]]; then BRANCH="master"; fi
        ;;
    github)
        CMD=git@github.com:karol-siedlaczek/$REPOSITORY.git
        if [[ -z $BRANCH ]]; then BRANCH="main"; fi
        ;;
    *)
        show_usage
        ;;
esac

if [[ -z "$REPOSITORY" || -z "$DIRECTORY" ]]
then
    show_usage
fi

REPOSITORY=$(sed -e 's/.*\///g' <<< $REPOSITORY)
DEST="$REPOPATH/${DIRECTORY^}/$REPOSITORY"
#echo "git clone --branch $BRANCH $CMD $DEST --progress"

git clone --branch $BRANCH $CMD $DEST --progress

echo -n $DEST | xclip -in -selection clipboard
