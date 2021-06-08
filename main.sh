#!/bin/bash
#
# Script Name - SITA [ Simple Interactive Todo Application ]
#
# Author - Nirbhay Gaur
# 
# Description - #TODO
#
# Error Log - Any errors associated with the script can be found in /path/to/logfile #TODO
#

### CONSTANTS ###
PROGNAME="$(basename $0)"
DATA_FILE="./$PROGNAME.data_file"
#RIGHT_NOW="$(date +"%x %r")"

### VARIABLES ###
task=
id=0

### FUNCTIONS ###

#init() 
#{   
#    clear
#    echo "Intializing the environment..."
#    sleep 2
#    clear
#    echo "Waking up the minions..."
#    sleep 2
#    clear
#    echo "Please wait while the minions do their work..."
#    sleep 2 
#    clear 
#    echo "Doing heavy lifting..."
#    sleep 2
#    clear
#    echo "Grabbing extra minions..."
#    sleep 2
#    clear
#    echo "We're working very hard...Really!"
#    sleep 3
#    clear
#    echo "BANANA!!!"
#    sleep 2
#    clear 
#    echo -e "Hello ${USER^}\n"
#    touch $DATA_FILE
#}

add()
{
    if [ -n "$task" ]; then
        echo "$id - $task" >> $DATA_FILE
        
    else 
        read -p "Enter task: " task
        echo "$id - $task" >> $DATA_FILE
    fi
    ((id++))
}

usage()
{
    cat <<- _EOF_
Usage: sita [OPTIONS]
SITA, short for Simple Interactive Todo Application, is a tool to organize your day to day tasks with very easy to use interface.

OPTIONS             DESCRIPTION                              EXAMPLE
-------             -----------                              -------
-a, --add           adds a task to todo list                 sita -a "feed my dog"
-d, --delete        deletes a task from todo list            sita -d [id]
-e, --edit          edits a task from todo list              sita -e [id] "walk my dog"
-h, --help          display this help and exit               sita -h
-l, --list          list all the task from todo list         sita -l   
            
_EOF_
}

### MAIN ###
#if [ -z "$1" ]; then
#    init
#    usage
#fi    

while [ "$1" != "" ]; do
    case $1 in
        -a | --add )            shift
                                task="$1"
                                add
                                ;;
        -d | --delete )         : #do something
                                ;;
        -e | --edit )           : #do something
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        -l | --list )           : #do something
                                ;;
        * )                     usage
                                exit 1 
    esac
    shift
done
