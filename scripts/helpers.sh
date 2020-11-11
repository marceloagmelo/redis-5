function log_info {
  #echo "---> `date +%T`     $@"
  echo "---> `date '+%d-%m-%Y %H:%M:%S'`     $@"
}

function log_and_run {
  log_info "Running $@"
  "$@"
}

function log_volume_info {
  log_info "Volume info for $@:"
  CONTAINER_DEBUG=${CONTAINER_DEBUG:-}
  if [[ "${CONTAINER_DEBUG,,}" != "true" ]]; then
    return
  fi

  #log_info "Volume info for $@:"
  set +e
  log_and_run mount
  while [ $# -gt 0 ]; do
    log_and_run ls -alZ $1
    shift
  done
  set -e
}
