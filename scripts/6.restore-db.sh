#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/utils.sh"

SQL_FILE=$1
BACKUP_DIR=$(dirname ${SQL_FILE})

function main() {
  print_yellow "\n Confirm to restore data to the database, this operation is irreversible!!! \n"
 
  if [[ ! -f "${SQL_FILE}" ]]; then
    print_error "File ${SQL_FILE} not exist"
    exit 1
  fi
  print_yellow "Restore database to ${DB_NAME} from ${SQL_FILE}"
  DB_HOST=$(get_config DB_HOST)
  DB_ENGINE=$(get_config DB_ENGINE)
  DB_NAME=$(get_config DB_NAME)
  case "${DB_HOST}" in
    "mysql")
      while [[ "$(docker inspect -f '{{ .State.Health.Status }}' smartdb_${DB_HOST})" != "healthy" ]]; do
        echo "Waiting for MySQL to be ready..."
        sleep 5
      done
      ;;
  esac
  db_images=$(get_db_images)

  case "${DB_ENGINE}" in
    "mysql")
      cmd='mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p"$DB_PASSWORD" $DB_NAME  < '${SQL_FILE}
      ;;
    *)
      print_error "Backup database not support for ${DB_ENGINE}"
      exit 1
      ;;
  esac
  if ! docker run --rm --env-file=${CONFIG_ENV} -i --network=smartdb -v "${BACKUP_DIR}:${BACKUP_DIR}" ${db_images} bash -c "${cmd}"; then
    print_error "Restore database failed. Please check the log or try manually."
    exit 1
  else 
    print_success "Restore database success."
  fi
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  if [[ -z "$1" ]]; then
    print_error "Please specify the backup file! Usage: ./smartdbcli.sh restore_db <backup_file>"
    exit 1
  fi
  if [[ ! -f $1 ]]; then
    print_error "Backup file not found: $1"
    exit 1
  fi
  main
fi
