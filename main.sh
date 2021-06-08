#!/bin/bash
#
# Script Name - SITA [ Simple Interactive Todo Application ]
#
# Author - Nirbhay Gaur
# 
# Description - An awesome tool to organize your day to day tasks with very easy to use interface.
#

### CONSTANTS ###
PROGNAME="$(basename $0)"
DATA_FILE="$HOME/.sita/.$PROGNAME.data_file"

### VARIABLES ###
task=
_id=
replace_text=
opt=

### FUNCTIONS ###

init() 
{
   declare -a msg=( 
                "Waking up minions..."
                "Assigning duties to minions..."
                "Please wait while minions do their work..."
                "We are working very hard...Really!"
                "Feeding lazy minions to unicorns..."
                "Grabbing extra minions..."
                "Almost there, hold tight..."
                "Tool initiated...All Good!"
             )
    for i in "${msg[@]}"; do
             clear
             echo "$i"
             sleep 4
         done
    if [ ! -d $HOME/.sita ]; then
        mkdir -p $HOME/.sita   
        touch $DATA_FILE
    fi
}

exit_err() 
{
    echo "$1" 1>&2
    exit 1
}

confirm()
{
    while true; do
        read -p "Are you sure? [y/n]: " opt 
        case $opt in 
            [Yy]* )  return 0;;
            [Nn]* )  return 1;;
            *     )  echo "ERROR: Answer in yes or no" 1>&2 
        esac
    done
}

add()
{
   if [ -f $DATA_FILE ]; then
        if [ -n "$task" ]; then
            echo "$task" >> $DATA_FILE
        else
            read -p "Enter task: " task
            echo "$task" >> $DATA_FILE
        fi
        echo "$task - has been added to your list."
    else 
        exit_err "ERROR: Minions found an abnormality: Run sita -i to initiate the tool"
    fi
    
}

delete()
{
    delete_check()
    {
        if [[ "$_id" =~ ^[0-9]+$ ]] && [ "$_id" -ne "0" ]; then
            if [ "$_id" -le $(wc -l < $DATA_FILE) ]; then
                if confirm; then
                    sed -i "${_id}d" $DATA_FILE
                    echo "Task deleted successfully"
                else 
                    echo "Calm down! Nothing is deleted"
                fi
            elif [ $(wc -l < $DATA_FILE) -eq "0" ]; then
                exit_err "ERROR: Your list is empty!: Add task first"
            else 
                exit_err "ERROR: ID does not match: Enter correct ID"
            fi
        else 
            exit_err "ERROR: Invalid input: Enter correct ID" 
        fi
    }
    
    if [ -f $DATA_FILE ]; then
        if [ -n "$_id" ]; then
            delete_check
        else
            read -p "Enter ID of the task: " _id
            delete_check
        fi
    else 
        exit_err "ERROR: Minions found an abnormality: Run sita -i to initiate the tool"
    fi
}

edit()
{
    edit_check()
    {
        if [[ "$_id" =~ ^[0-9]+$ ]] && [ "$_id" -ne "0" ]; then
            if [ "$_id" -le $(wc -l < $DATA_FILE) ]; then
                if confirm; then
                    sed -i "${_id}s/.*/${replace_text}/" $DATA_FILE
                    echo "Task updated successfully"
                else 
                    echo "Nothing's changed, You are still an ugly bitch."
                fi
            elif [ $(wc -l < $DATA_FILE) -eq "0" ]; then
                exit_err "ERROR: Your list is empty!: Add task first"
            else
                exit_err "ERROR: ID does not match: Enter correct ID"
            fi
        else 
            exit_err "ERROR: Invalid input: Enter correct ID" 
        fi
    }

    if [ -f $DATA_FILE ]; then
        if [ -n "$_id" ]; then
            edit_check
        else 
            read -p "Enter ID of the task: " _id
            read -p "Enter updated task: " replace_text
            edit_check
        fi
    else 
        exit_err "ERROR: Minions found an abnormality: Run sita -i to initiate the tool"
    fi
}

list()
{
    if [ -f $DATA_FILE ]; then
        if [ $(wc -l < $DATA_FILE) -eq "0" ]; then 
            exit_err "ERROR: No task available: Nothing to display"
        else 
            printf "%6s %6s\n" "ID" "TASKS"
            cat -n $DATA_FILE
        fi
    else 
        exit_err "ERROR: Minions found an abnormality: Run sita -i to initiate the tool"
    fi
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
 
If you choose not to run single line commands as shown above, simply run:
    sita [OPTIONS]

Furthermore, SITA offers an interactive mode. To perform above tasks in interactive mode, just run: sita

_EOF_
}

### MAIN ###
trap "exit" SIGHUP SIGINT SIGTERM

if [ -z "$1" ]; then
    usage
fi    

while [ "$1" != "" ]; do
    case $1 in
        -a | --add )            shift
                                task="$1"
                                add
                                exit
                                ;;
        -d | --delete )         shift
                                _id="$1"
                                delete
                                exit
                                ;;
        -e | --edit )           shift
                                _id="$1"
                                replace_text="$2"
                                edit
                                exit
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        -i | --init )           init
                                exit
                                ;;
        -l | --list )           list
                                exit
                                ;;
        * )                     usage
                                exit 1 
    esac
    shift
done
### EOC ###
