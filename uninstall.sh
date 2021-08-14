#!/bin/bash 
#
# SITA uninstall script
#
# Run this script to uninstall SITA from your system
#
# Script by Nirbhay Gaur

### VARIABLE ###
c=0

### FUNCTIONS ###

sita_backup()
{
    echo -e "Backup sequence initiated...\n" &&
    sleep 0.5 &&
    mkdir -p $HOME/.sita_backup &&
    sleep 0.5 &&
    cp $HOME/.sita/.sita.data_file $HOME/.sita_backup/sita.data_file.backup &&
    sleep 0.5 &&
    echo -e "All data is saved as $HOME/.sita_backup/sita.data_file.backup\n"
}

backup_file() 
{
    local opt=

    while true; do
        read -p "Do you wish to backup the data? [y/n]: " opt
        case $opt in 
            [Yy]* )    sita_backup; return 0;;
            [Nn]* )    echo -e "Selling all your Data to suckerberg\n"; return 0;;
            *     )    echo "ERROR: Answer Y/N?" 1>&2
        esac
    done
}

del_file()
{
    if [ -d "$HOME/.sita" ]; then
        backup_file
        rm -rf "$HOME/.sita"
        echo "Swapping time and space..."
        sleep 3
        return 0
    else 
        # echo -e "ERROR: Unable to remove $HOME/.sita directory: Directory does not exist\n" 1>&2 
        ((c++))
        return 1
    fi
}

del_link()
{
    if [ -f "$HOME/.local/bin/sita" ]; then
        rm -f "$HOME/.local/bin/sita"
        echo "Spinning violently around the y-axis..."
        sleep 3
        return 0
    else
        # echo -e "ERROR: Unable to remove $HOME/.local/bin/sita file: File does not exist\n" 1>&2
        ((c++))
        return 1
    fi
}

### MAIN ###

del_link
del_file

if [ "$c" -eq 0 ]; then
    clear
    echo "SITA is successfully removed from your system. LOSER!"
else
    echo -e "ERROR: Minions couldn't find any file or directory associated to SITA, it may have been deleted by someone. Find it out, Sherlock! \nThis means SITA is already uninstalled from your system, LOSER!"
fi


#             |\                         /|
#             | \                       / |
#             |  \                     /  |
#             |   \   _,.-------.,_   /   |
#             |   ,\~'             '~/,   |
#             | ,;                     ;, |
#             |;                         ;|
#             |'         Damaged         '|
#            ,;                           ;,
#            ; ;      .           .      ; ;
#            | ;   ______       ______   ; |
#            |  `/~"     ~" . "~     "~\'  |
#            |  ~  ,-~~~^~, | ,~^~~~-,  ~  |
#             |   |        }:{        |   |
#             |   l       / | \       !   |
#             .~  (__,.--" .^. "--.,__)  ~.
#             |     ---;' / | \ `;---     |
#              \__.       \/^\/       .__/
#               V| \                 / |V
#                | |T~\___!___!___/~T| |
#                | |`IIII_I_I_I_IIII'| |
#                |  \,III I I I III,/  |
#                 \   `~~~~~~~~~~'    /
#                   \   .       .   /     
#                     \.    ^    ./
#                       ^~~~^~~~^
