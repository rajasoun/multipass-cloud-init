#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/log.bash"

function raise_error(){
  user_msg "${1}" >&2
  return 1
}

function wait_till_vm_running(){
    while :
    do
        status=$(multipass ls | grep "$VM_NAME"  |  awk '{print $2}')
        [ ! $status = "Running"  ] || break
        sleep 5
        user_msg "Waiting up $VM_NAME VM to come up ..."
    done
}

## Return 0 is VM not exists and 1 if exists
function check_vm_exists(){
  if [ "$( multipass list | grep -c "$VM_NAME")"   -ne 0  ] 2>/dev/null; then
    user_msg "VM: $VM_NAME is Provisioned"
    log_info "(check_vm_exists) VM: $VM_NAME is Provisioned"
    return 1
  else
    user_msg "VM: $VM_NAME Yet To Be Provisioned."
    log_info "(check_vm_exists) VM: $VM_NAME Yet To Be Provisioned."
    return 0
  fi
}

function run_main(){
    raise_error "$@"
    wait_till_vm_running
    check_vm_exists
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main "$@"
  then
    exit 1
  fi
fi