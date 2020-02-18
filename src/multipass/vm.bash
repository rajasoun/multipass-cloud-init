#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/check.bash"
source "$(dirname "${BASH_SOURCE[0]}")/log.bash"

function provision(){
    check_vm_exists || return 1
    log_info "(provision) $VM_NAME Started"
    start=$(date +%s)
    multipass launch -c"$CPU" -m"$MEMORY" -d"$DISK" -n "$VM_NAME" lts --cloud-init "$CLOUD_INIT_FILE" 
    end=$(date +%s)
    runtime=$((end-start))
    log_time $runtime
    log_info "(provision) $VM_NAME Completed in $runtime seconds"
}

function view_log() {
    ! check_vm_exists || return 1
    user_msg "Cloud Init Logs Can be Viewed Only when the VM Instance Goes to Running State"
    wait_till_vm_running
    multipass exec "$VM_NAME" -- tail  -f  /var/log/cloud-init-output.log
}

function shell() {
    ! check_vm_exists || return 1
    multipass shell "$VM_NAME"
}

function destroy() {
    ! check_vm_exists || return 1
    log_info "(destroy) $VM_NAME Started"
    multipass delete "$VM_NAME" && multipass purge
    echo "$VM_NAME Destroyed"
    log_info "(destroy) $VM_NAME Completed"
}

function run_main(){
    provision
    view_log
    shell
    destroy
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main
  then
    exit 1
  fi
fi