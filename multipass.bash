#!/usr/bin/env bash

#References:
# https://linuxize.com/post/how-to-set-dns-nameservers-on-ubuntu-18-04/
# https://discourse.ubuntu.com/t/troubleshooting-networking-on-macos/12901
# https://github.com/lucaswhitaker22/bash_menus/blob/master/bash_menus/demo.sh

function include () {
    if [[ -f "dev.$1" ]]; then
        # shellcheck disable=SC1090
        source "dev.$1"  #source from custom env file if present
    else
        # shellcheck disable=SC1090
        source "$1" #source from deafult env file
    fi
}

# Displays Time in misn and seconds
function display_time {
    local T=$1
    local D=$((T/60/60/24))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))
    (( D > 0 )) && printf '%d days ' $D
    (( H > 0 )) && printf '%d hours ' $H
    (( M > 0 )) && printf '%d minutes ' $M
    (( D > 0 || H > 0 || M > 0 )) && printf 'and '
    printf '%d seconds\n' $S
}

function menu() {
    tput clear
    title=$1
    in=$2
    arr=$(echo "$in" | tr "," "\n")
    x=1
    y=1
    
    tput cup $y $x
    tput rev;echo " $title "; tput sgr0
    x=$((x+${#title}+4))
    i=0
    for n in $arr
    do
        # shellcheck disable=SC2004
        tput cup $(( y+$i )) $x
            str="$n" 
            echo "$((i+1)). $str"
        i=$((i+1))
    done
    # shellcheck disable=SC2004
    tput cup $(( y+$i+1 )) $((x-$((${#title}+4))))
    # shellcheck disable=SC2162
    read -p "Enter your choice [1-$i] " choice
    return "$choice"
}

function check_vm_running(){
  multipass info "$VM_NAME" || raise_error "Exiting.. "
}

function choose_action_from_menu(){
    menu "Multipass Manager" "Provision,Shell,Destroy"
    choice=$?
    case $choice in 
        1)  [ "$( multipass list | grep -c "$VM_NAME")"   -ne 0  ] && raise_error "VM Exists. Exiting..."
            start=$(date +%s)
            multipass launch -c"$CPU" -m"$MEMORY" -d"$DISK" -n "$VM_NAME" lts --cloud-init "$CLOUD_INIT_FILE" || exit
            end=$(date +%s)
            runtime=$((end-start))
            display_time $runtime
            ;;
        2)
            check_vm_running
            multipass shell "$VM_NAME"
            ;;
        3)
            check_vm_running
            multipass delete "$VM_NAME" && multipass purge
            echo "$VM_NAME Destroyed"
            ;;
        *) 
            echo "Invalid Input"
            ;;
    esac
}

include "instance.env"
choose_action_from_menu





