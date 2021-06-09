#!/bin/bash
#
# SITA init file
#
# Run this file, if you are using SITA for first time to install it properly on your system
#

### Functions ###

is_root () {
    return $(id -u)
}

if is_root; then
    echo "Error: need to call this script as a normal user, not as root!" 
    exit 1
fi

### Main ###

if [ -f ./main.sh ]; then
        mkdir -p $HOME/.sita &&
        cp ./main.sh $HOME/.sita && 
        cd $HOME/.sita &&
        chmod +x main.sh
        if [ -h sita ]; then
            rm ./sita
        fi
        ln -s main.sh sita && 
        cp sita $HOME/.local/bin &&
        echo "SITA is successfully installed on your system..." &&
        sleep 3 &&
        echo "Initializing SITA..." &&
        sleep 3 &&
        sita -i
else 
    echo "ERROR: Missing file: main.sh missing" 1>&2
    exit 1
fi
