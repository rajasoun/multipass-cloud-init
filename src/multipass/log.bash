#!/usr/bin/env bash

# Displays Time in misn and seconds
function log_time {
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

function user_msg(){
  echo -e "$1"
}

# Log the given message at the given level. All logs are written to stderr with a timestamp.
function log {
  local -r level="$1"
  local -r message="$2"
  local -r timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  local -r script_name="$(basename "$0")"
  >&2 echo -e "${timestamp} [${level}] [$script_name] ${message}" >> log.out
}

# Log the given message at INFO level. All logs are written to stderr with a timestamp.
function log_info {
  local -r message="$1"
  log "INFO" "$message"
}

# Log the given message at WARN level. All logs are written to stderr with a timestamp.
function log_warn {
  local -r message="$1"
  log "WARN" "$message"
}

# Log the given message at ERROR level. All logs are written to stderr with a timestamp.
function log_error {
  local -r message="$1"
  log "ERROR" "$message"
}

function run_main(){
    log "$@"
    log_info "$@"
    log_warn "$@"
    log_warn "$@"
    log_error "$@"
    log_time "$@"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main "$@"
  then
    exit 1
  fi
fi