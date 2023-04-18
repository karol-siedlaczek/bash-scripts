#!/bin/bash

WEASEL_PATH="<script_path>"

echo -n "loading SSH keys from pageant... "
"$WEASEL_PATH/weasel-pageant" -k> /dev/null 2> /dev/null
eval $("$WEASEL_PATH/weasel-pageant" -r -a "/tmp/.weasel-pageant-$USER")> /dev/null 2> /dev/null
sleep 1
ssh_keys_loaded=$(ssh-add -l | grep -c SHA)

if [[ $ssh_keys_loaded -gt 0 ]];  then
    echo -e "loaded $ssh_keys_loaded keys"
else
    echo -e "failed to load any key"
fi
