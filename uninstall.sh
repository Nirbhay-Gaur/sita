#!/bin/bash 
#
# SITA uninstall file
#
# Run this file to uninstall SITA from your system
#

### VARIABLE ###
c=0

### FUNCTIONS ###

del_file()
{
    if [ -d "$HOME/.sita" ]; then
        rm -rf "$HOME/.sita"
        echo "Swapping time and space..."
        sleep 3
        return 0
    else 
        echo -e "ERROR: Unable to remove $HOME/.sita directory: Directory does not exist\n" 1>&2 
        ((c++))
        return 1
    fi
}

del_link()
{
    if [ -h "$HOME/.local/bin/sita" ]; then
        rm -f "$HOME/.local/bin/sita"
        echo "Spinning violently around the y-axis..."
        sleep 3
        return 0
    else
        echo -e "ERROR: Unable to remove $HOME/.local/bin/sita file: File does not exist\n" 1>&2
        ((c++))
        return 1
    fi
}

### MAIN ###

del_file
del_link

if [ "$c" -eq 0 ]; then
    clear
    echo "SITA is successfully removed from your system. LOSER!"
else
    echo -e "ERROR: Minions couldn't find any file or directory associated to SITA, it may have been deleted by someone. Find it out, Sherlock! \nThis means SITA is already uninstalled from your system, LOSER!"
fi
