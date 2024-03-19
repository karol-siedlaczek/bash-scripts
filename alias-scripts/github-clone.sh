#!/bin/bash

REPO=$1
DEST=$2
BRANCH=$3

if [[ -z "$REPO" || -z "$DEST" ]]
then
        echo -e "Syntax error\nUsage: $0 <REPO> <DEST> <BRANCH> | main"
        exit 1
fi

if [[ -z $BRANCH ]]; then BRANCH="main"; fi

git clone --branch $BRANCH git@github.com:karol-siedlaczek/$REPO.git ~/repository/$DEST/$REPO --progress
