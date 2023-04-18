#!/bin/bash

REPO_PATH="<repo_path>"
REPO_TOKEN="<fine_grained_token>"
TMP_DIR="/tmp/.ssh-config.repo"

[ -d $TMP_DIR ] && rm -rf $TMP_DIR

echo "cloning ssh config files..."
REPO="https://oauth2:${REPO_TOKEN}@${REPO_PATH}"

if ! git clone --quiet $REPO $TMP_DIR > /dev/null
then
        echo "cloning ssh config files from '${REPO_PATH}' failed"
else
        mkdir -p ~/.ssh/config.d
        mv $TMP_DIR/config.d/* ~/.ssh/config.d/
        cat $TMP_DIR/config > ~/.ssh/config
        chmod 600 ~/.ssh/config*
        rm -rf $TMP_DIR
        echo "ssh config files loaded"
fi
