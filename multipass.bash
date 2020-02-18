#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASH_COMMONS_SRC_DIR="$SCRIPT_DIR/src"

source "$BASH_COMMONS_SRC_DIR/load"

function choose_action_from_menu(){
    menu "Multipass Manager" "Provision,ViewLog,Shell,Destroy"
    choice=$?
    log_info "(menu) Choice: $choice"
    case $choice in 
        1) provision ;;
        2) view_log ;;
        3) shell ;;
        4) destroy ;;
        *) user_msg "Invalid Input" ;;
    esac
}

source "instance.env"
choose_action_from_menu
