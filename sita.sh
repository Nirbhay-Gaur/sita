#!/bin/bash
#
# SITA init file
#
# Run this file, if you are using SITA for first time to install it properly on your system
#

### Main ###


mkdir -p $HOME/bin/
if [ -f ./main.sh ]; then
        mkdir -p $HOME/.sita &&
        cp * $HOME/.sita && 
        cd $HOME/.sita && 
        ln -s main.sh sita && 
        cp sita $HOME/bin/ &&
        echo export PATH=$PATH:$HOME/bin/ >> $HOME/.bashrc && 
        source $HOME/.bashrc && 
        echo "SITA is successfully installed on your system..." &&
        sleep 3 &&
        echo "Initializing SITA..." &&
        sleep 5 &&
        sita -i
else 
    echo "ERROR: Missing file: main.sh missing" 1>&2
    exit 1
fi
