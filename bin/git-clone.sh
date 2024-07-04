#!/bin/bash

REPOSITORY=$2
DIRECTORY=$3
BRANCH=$4

function show_usage() {
    echo -e "Usage: git-clone {gerrit|github|gitlab-p4|gitlab} <repository> <directory> [<branch>|main]" >&2
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
    gitlab-pl)
        CMD=git@github.net.pl:$REPOSITORY.git
        if [[ -z $BRANCH ]]; then BRANCH="main"; fi
        ;;
    gitlab)
        CMD=git@drm-gitlab.redlabs.pl:$REPOSITORY.git
        if [[ -z $BRANCH ]]; then BRANCH="master"; fi
        ;;
    *)
        show_usage
        ;;
esac

if [[ -z "$REPOSITORY" || -z "$DIRECTORY" ]]
then
    show_usage
fi

#REPOSITORY=$(sed -e 's/.*\///g' <<< $REPOSITORY) # To upper case
DEST="$REPOPATH/${DIRECTORY^}/$REPOSITORY"
#echo "git clone --branch $BRANCH $CMD $DEST --progress"

git clone --branch $BRANCH $CMD $DEST --progress
git config -f $DEST/.git/config user.name "Karol Siedlaczek"

if [[ $1 -eq "gitlab" || $1 -eq "gerrit" || $1 -eq "gitlab-p4" ]]; then
    git config -f $DEST/.git/config user.email "karol.siedlaczek@redge.com"
else
    git config -f $DEST/.git/config user.email "karol@siedlaczek.com.pl"
fi

echo -n $DEST | xclip -in -selection clipboard
