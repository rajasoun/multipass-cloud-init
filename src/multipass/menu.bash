#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/log.bash"

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

    [ -n "$choice" ] && [ "$choice" -eq "$choice" ] 2>/dev/null
    if [ $? -ne 0 ]; then
        user_msg "$choice is not number..."
        log_info "$choice is not number..."
        choice="999"
    fi

    return "$choice"
}

function run_main(){
    menu "$@"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main "$@"
  then
    exit 1
  fi
fi