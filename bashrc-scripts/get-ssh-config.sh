#!/bin/bash

REPO_PATH="<REPO_URL>"
REPO_TOKEN="<OAUTH2_TOKEN>"
TMP_DIR="/tmp/.ssh-config-${RANDOM}-${USER}.repo"

[ -d $TMP_DIR ] && rm -rf $TMP_DIR

echo -n "cloning ssh config files... "
REPO="https://oauth2:${REPO_TOKEN}@${REPO_PATH}"

if ! git clone --quiet $REPO $TMP_DIR > /dev/null
then
        echo "failed to load ssh config from '${REPO_PATH}' repo"
else
        mkdir -p ~/.ssh/config.d
        mv $TMP_DIR/config.d/* ~/.ssh/config.d/
        cat $TMP_DIR/config > ~/.ssh/config
        chmod 700 ~/.ssh/config.d && chmod 600 ~/.ssh/config ~/.ssh/config.d/*
        rm -rf $TMP_DIR
        echo "success"
fi
