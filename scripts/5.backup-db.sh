#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/utils.sh"

VOLUME_DIR=$(get_config VOLUME_DIR)
BACKUP_DIR="${VOLUME_DIR}/backup-db"
CURR_VERSION=$(get_config CURR_VERSION)

function main() {
  if [[ ! -d ${BACKUP_DIR} ]]; then
    mkdir -p ${BACKUP_DIR}
  fi
  print_yellow "\n Backup database."
  
  DB_HOST=$(get_config DB_HOST)
  DB_ENGINE=$(get_config DB_ENGINE)
  DB_NAME=$(get_config DB_NAME)
  case "${DB_HOST}" in
    "mysql")
      while [[ "$(docker inspect -f '{{ .State.Health.Status }}' dbagent_${DB_HOST})" != "healthy" ]]; do
        echo "Waiting for MySQL to be ready..."
        sleep 5
      done
      ;;
  esac
  db_images=$(get_db_images)

  case "${DB_ENGINE}" in
    "mysql")
      SQL_FILE="${BACKUP_DIR}/${DB_NAME}-${CURR_VERSION}-$(date +%Y%m%d%H%M%S).sql"
      cmd='mysqldump --skip-add-locks --skip-lock-tables --single-transaction --default-character-set=utf8 -h$DB_HOST -P$DB_PORT -u$DB_USER -p"$DB_PASSWORD" $DB_NAME  > '${SQL_FILE}
      ;;
    *)
      print_error "Backup database not support for ${DB_ENGINE}"
      exit 1
      ;;
  esac
  if ! docker run --rm --env-file=${CONFIG_ENV} -i --network=dbagent -v "${BACKUP_DIR}:${BACKUP_DIR}" ${db_images} bash -c "${cmd}"; then
    print_error "Backup database failed."
    rm -rf "${SQL_FILE}"
    exit 1
  else 
    print_success "Backup database successfully. The backup file is ${SQL_FILE}"
  fi
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main
fi
