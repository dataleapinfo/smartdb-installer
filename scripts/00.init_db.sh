#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/utils.sh"

PROJECT_DIR=$(dirname "${BASE_DIR}")

function start_db() {
  EXEC_COMMANDS=$(get_db_service_commands)
  ${EXEC_COMMANDS} up -d
  
  db_host=$(get_config DB_HOST)
  case "${db_host}" in
    "mysql")
      while [[ "$(docker inspect -f '{{ .State.Health.Status }}' smartdb_${db_host})" != "healthy" ]]; do
        echo "Waiting for MySQL to be ready..."
        sleep 5
      done
      ;;
  esac
}

function init_db() {
  db_engine=$(get_config DB_ENGINE "mysql")
  db_user=$(get_config DB_USER)
  db_password=$(get_config DB_PASSWORD)
  docker exec -i smartdb_mysql mysql -u"$db_user" -p"$db_password" < "${PROJECT_DIR}/sql/${db_engine}/smartdata.sql"
}

function main() {
  print_yellow ">>>1. Start database ..."
  start_db
  sleep 0.5
  print_yellow ">>>2. Init database ..."
  init_db
  print_done
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main
fi
