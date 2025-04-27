#!/usr/bin/env bash

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cd "${PROJECT_DIR}" || exit 1

. "${PROJECT_DIR}/scripts/utils.sh"

action=${1-}
target=${2-}
args=("$@")

function check_config_env() {
  if [[ ! -f "${CONFIG_ENV}" ]]; then
    echo "Config file not found: ${CONFIG_ENV}, please usage ./dbagentcli.sh -h"
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
  echo "${PROJECT_NAME} Deployment Management"
  echo
  echo "Usage:"
  echo "  ./dbagentcli.sh <action> <args>"
  echo "  ./dbagentcli.sh help"
  echo
  echo "Installation Actions: "
  echo "  install                   Install ${PROJECT_NAME}"
  echo "  upgrade                   Upgrade ${PROJECT_NAME}"
  echo
  echo "Components Actions: "
  echo "  config                    Config ${PROJECT_NAME}"
  echo "  start                     Start components"
  echo "  stop                      Stop components"
  echo "  restart                   Restart components"
  echo "  uninstall                 Uninstall ${PROJECT_NAME}"
  echo
  echo "Database Actions: "
  echo "  backup_db                 Backup database"
  echo "  restore_db [backup_file]  Restore database"
  echo
  echo "More Actions: "
  echo "  status                    Show ${PROJECT_NAME} status"
  echo "  logs [service]            Show ${PROJECT_NAME} logs"
  echo "  version                   Show ${PROJECT_NAME} version"
  echo "  check_update              Check version"
  echo 
}
EXEC_COMMANDS=""

function start() {
  confirm="n"
  read_from_input confirm "Are you sure you want to start ${PROJECT_NAME}?" "y/n" "${confirm}"
  if [[ "${confirm}" != "y" ]]; then
    exit 1
  fi
  ${EXEC_COMMANDS} up -d
}
function stop() {
  confirm="n"
  target_name=${PROJECT_NAME}
  if [[ -n "${target}" ]]; then
    target_name=${target}
  fi
  read_from_input confirm "Are you sure you want to stop ${target_name}?" "y/n" "${confirm}"
  if [[ "${confirm}" != "y" ]]; then
    exit 1
  fi
  if [[ -n "${target}" ]]; then
    ${EXEC_COMMANDS} stop "${target}" && ${EXEC_COMMANDS} rm -f "${target}"
    return
  fi
  echo ${EXEC_COMMANDS}
  ${EXEC_COMMANDS} down -v
}

function restart() {
  confirm="n"
  read_from_input confirm "Are you sure you want to restart ${PROJECT_NAME}?" "y/n" "${confirm}"
  if [[ "${confirm}" != "y" ]]; then
    exit 1
  fi
  
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

function check_update() {
  curr_version=$(get_curr_version)
  latest_version=$(get_latest_version)
  echo "latest version: ${latest_version}, curr_version: ${curr_version}"
  if [[ "${curr_version}" == "${latest_version}" ]]; then
    print_green "You are using the latest version: ${curr_version}"
    echo 
    return
  fi
  if [[ -n  "${latest_version}" ]] && [[ ${latest_version} =~ v.* ]]; then
    print_yellow "There is a new version: ${latest_version}"
  else 
    exit 1
  fi

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
      bash "${SCRIPT_DIR}/3.app-config.sh" "$target"
      ;;
    init_db)
      exec_db_migrate
      ;;
    backup_db)
      bash "${SCRIPT_DIR}/5.backup-db.sh"
      ;;
    restore_db)
      bash "${SCRIPT_DIR}/6.restore-db.sh" "$target"
      ;;
    check_update)
      check_update
      ;;
    upgrade)
      bash "${SCRIPT_DIR}/7.upgrade.sh" "$target"
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
