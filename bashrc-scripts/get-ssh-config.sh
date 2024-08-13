#!/bin/bash

REPO_PATH="<REPO_URL>"
REPO_TOKEN="<OAUTH2_TOKEN>"

tmp_dir="/tmp/.ssh-config-${RANDOM}-${USER}.repo"

[ -d $tmp_dir ] && rm -rf $tmp_dir

echo -n "Cloning ssh config files... "
REPO="https://oauth2:${REPO_TOKEN}@${REPO_PATH}"

if ! git clone --quiet $REPO $tmp_dir > /dev/null
then
        echo "Failed to load ssh config from '${REPO_PATH}' repo"
else
        mkdir -p ~/.ssh/config.d
        mv $tmp_dir/config.d/* ~/.ssh/config.d/
        cat $tmp_dir/config > ~/.ssh/config
        chmod 700 ~/.ssh/config.d && chmod 600 ~/.ssh/config ~/.ssh/config.d/*
        dos2unix --quiet ~/.ssh/config
        rm -rf $tmp_dir
        echo "success"
fi
