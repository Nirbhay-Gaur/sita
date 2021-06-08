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
EXCODE="$?"
#RIGHT_NOW="$(date +"%x %r")"

### VARIABLES ###
task=
id=
line_num=
replace_text=
opt=

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

confirm()
{
    while true; do
        read -p "Are you sure? [y/n]: " opt 
        case $opt in 
            [Yy]* )  return 0;;
            [Nn]* )  return 1;;
            *     )  echo "Err...answer in yes or no, dumbo!" 
        esac
    done
}

add()
{
    if [ -n "$task" ]; then
        echo "$task" >> $DATA_FILE
    else 
        read -p "Enter task: " task
        echo "$task" >> $DATA_FILE
    fi
    echo "$task - has been added to your list."
}

delete()
{
    if [[ "$id" =~ ^[0-9]+$ ]] && [ "$id" -ne "0" ]; then
        if [ "$id" -le $(wc -l < $DATA_FILE) ]; then
            if confirm; then
                sed -i "${id}d" $DATA_FILE
                echo "Task deleted successfully"
            else 
                echo "Calm down! Nothing is deleted"
            fi
        else
            echo "Entered id does not match"
        fi
    else 
        echo "Invalid input. Enter correct id" 
    fi
}

edit()
{
    if [[ "$id" =~ ^[0-9]+$ ]] && [ "$id" -ne "0" ]; then
        if [ "$id" -le $(wc -l < $DATA_FILE) ]; then
            if confirm; then
                sed -i "${id}s/.*/${replace_text}/" $DATA_FILE
                echo "Task updated successfully"
            else 
                echo "Nothing's changed, You are still an ugly bitch."
            fi
        else
            echo "Entered id does not match"
        fi
    else 
        echo "Invalid input. Enter correct id" 
    fi
}

list()
{
 echo "TODO"
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
                                exit
                                ;;
        -d | --delete )         shift
                                id="$1"
                                delete
                                exit
                                ;;
        -e | --edit )           shift
                                id="$1"
                                replace_text="$2"
                                edit
                                exit
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
