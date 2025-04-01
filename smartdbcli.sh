#!/usr/bin/env bash

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cd "${PROJECT_DIR}" || exit 1

. "${PROJECT_DIR}/scripts/utils.sh"

action=${1-}
target=${2-}
args=("$@")

function check_config_env() {
  if [[ ! -f "${CONFIG_ENV}" ]]; then
    echo "Config file not found: ${CONFIG_ENV}, please usage ./smartdbcli.sh -h"
    return 3
  fi
   
  if [[ -f .env ]]; then
    if ! ls -l .env | grep "${CONFIG_ENV}" &>/dev/null; then
      echo ".env $(gettext 'There is a problem with the soft connection, Please update it again')"
      rm -f .env
    fi
  fi

  if [[ ! -f ".env" ]]; then
    ln -s "${CONFIG_ENV}" .env
  fi

  if [[ ! -f "./yml/.env" ]]; then
    ln -s "${CONFIG_ENV}" ./yml/.env
  fi
}

function pre_check() {
  check_config_env || return 3;
}

function help() {
  echo "SmartDB Deployment Management"
  echo
  echo "Usage:"
  echo "  ./smartdbcli.sh <action> <args>"
  echo "  ./smartdbcli.sh help"
  echo
  echo "Installation Actions: "
  echo "  install                   Install SmartDB"
  echo "  init_db                   Initialize SmartDB Database"
  echo
  echo "Components Actions: "
  echo "  start                     Start components"
  echo "  stop                      Stop components"
  echo "  restart                   Restart components"
  echo
  echo "Database Actions: "
  echo "  backup_db                 Backup database"
  echo "  restore_db [backup_file]  Restore database"
  echo
  echo "More Actions: "
  echo "  status                    Show SmartDB status"
  echo "  logs [service]            Show SmartDB logs"
  echo "  version                   Show version"
  echo "  uninstall                 Uninstall SmartDB"
  # echo "  config                  Config SmartDB"
  echo 
}
EXEC_COMMANDS=""

function start() {
  ${EXEC_COMMANDS} up -d
}
function stop() {
  if [[ -n "${target}" ]]; then
    ${EXEC_COMMANDS} stop "${target}" && ${EXEC_COMMANDS} rm -f "${target}"
    return
  fi
  echo ${EXEC_COMMANDS}
  ${EXEC_COMMANDS} down -v
}

function restart() {
  stop
  echo -e "\n"
  sleep 1
  start
}

function start_db() {
  EXEC_DB_COMMANDS=$(get_db_service_commands)

  echo ${EXEC_DB_COMMANDS}
  ${EXEC_DB_COMMANDS} up -d
}

function stop_db() {
  EXEC_DB_COMMANDS=$(get_db_service_commands)

  echo ${EXEC_DB_COMMANDS}
  ${EXEC_DB_COMMANDS} down -v
}

function logs() {
  if [[ -z "${target}" ]]; then
    ${EXEC_COMMANDS} logs --tail 100 -f
  else
    name=$(get_service_name "${target}")
    docker logs -f "${name}" --tail 100
  fi
}

function rm_network() {
  docker network rm smartdb &>/dev/null
}

function start_network() {
  print_yellow "Initialize network ..."
  docker network rm smartdb &>/dev/null
  docker network create smartdb

  # use_ipv6=$(get_config USE_IPV6)
  # cmd="docker compose"
  # if [[ "${use_ipv6}" != "1" ]]; then
  #   cmd+=" -f yml/network.yml"
  # else
  #   cmd+=" -f yml/network-v6.yml"
  # fi
  #
  # "${cmd} up -d"
}
function main() {
  if [[ "${action}" == "help" || "${action}" == "--help" || "${action}" == "h" || "${action}" == "-h" ]]; then
    echo ""
  elif [[ "${action}" == "install" ]]; then 
    echo ""
  else
    pre_check || return 3
    EXEC_COMMANDS=$(get_app_service_commands)
  fi
  case "${action}" in
    help | --help | -h | h)
      help
      ;;
    install)
      bash "${SCRIPT_DIR}/4.install.sh"
      start_network
      ;;
    init_db)
      bash "${SCRIPT_DIR}/00.init-db.sh"
      ;;
    start)
      start
      ;;
    stop)
      stop 
      ;;
    restart)
      restart
      ;;
    status)
      ${EXEC_COMMANDS} ps
      ;;
    logs)
      logs    
      ;;
    version | -v | --version)
      get_curr_version  
      ;;
    config)
      echo "..."
      ;;
    backup_db)
      bash "${SCRIPT_DIR}/5.backup-db.sh"
      ;;
    restore_db)
      bash "${SCRIPT_DIR}/6.restore-db.sh" "$target"
      ;;
    uninstall)
      bash "${SCRIPT_DIR}/8.uninstall.sh"
      ;;
    *)
      echo "unknown action: ${action}"
      help
      ;;
  esac
}

main "$@"
