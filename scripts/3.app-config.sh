#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/utils.sh"

function set_data_dir() {
  print_yellow "\n1. Config data directory."
  volume_dir=$(get_config VOLUME_DIR "/opt/smartdb")
  confirm="n"
  read_from_input confirm "Do you need to customize the data directory, otherwise default settings will be used ${volume_dir}?" "y/n" "${confirm}"
  if [[ "${confirm}" == "y" ]]; then
    echo
    echo " such as) /data/smartdb"
    echo "Waring: you can not change it after installation, otherwise the database may be lost"
    echo
    df -h | grep -Ev "devfs|tmpfs|overlay|shm|snap|boot"
    echo
    read_from_input volume_dir "Data persistent storage directory" "" "${volume_dir}"
    if [[ "${volume_dir}" == "y" ]]; then
      print_failed
      echo
      set_data_dir
    fi
  fi
  if [[ ! -d "${volume_dir}" ]]; then
    mkdir -p ${volume_dir}
    chmod 700 ${volume_dir}
  fi
  set_config VOLUME_DIR ${volume_dir}
}

function set_db_config() {
  local db_engine=$1
  local db_host=$2
  local db_port=$3
  local db_user=$4
  local db_password=$5
  local db_name=$6

  set_config DB_ENGINE "${db_engine}"
  set_config DB_HOST "${db_host}"
  set_config DB_PORT "${db_port}"
  set_config DB_USER "${db_user}"
  set_config DB_PASSWORD "${db_password}"
  set_config DB_NAME "${db_name}"
}

function set_external_db() {
  local db_engine=$1
  db_host=$(get_config DB_HOST)
  read_from_input db_host "Please enter DB server IP" "" "${db_host}"
  if [[ "${db_host}" == "127.0.0.1" || "${db_host}" == "localhost" ]]; then
    print_error "Can not use localhost as DB server IP"
  fi
  db_port=$(get_config DB_PORT)
  read_from_input db_port "Please enter DB server port" "" "${db_port}"
  db_name=$(get_config DB_NAME)
  read_from_input db_name "Please enter DB database name" "" "${db_name}"
  db_user=$(get_config DB_USER)
  read_from_input db_user "Please enter DB username" "" "${db_user}"
  db_password=$(get_config DB_PASSWORD)
  read_from_input db_password "Please enter DB password" "" "${db_password}"

  set_db_config "${db_engine}" "${db_host}" "${db_port}" "${db_user}" "${db_password}" "${db_name}"
}

function set_internal_db() {
  local db_engine=$1
  local db_host=$2
  local db_port=$3
  local db_user=$4
  db_user=$(get_config DB_USER)
  if [[ -z "${db_user}" ]]; then
    db_user=smartdata
  fi
  db_password=$(get_config DB_PASSWORD)
  if [[ -z "${db_password}" ]]; then
    db_password=$(generate_random)
  fi
  db_name=$(get_config DB_NAME)
  if [[ -z "${db_name}" ]]; then
    db_name=smartdata
  fi

  set_db_config "${db_engine}" "${db_host}" "${db_port}" "${db_user}" "${db_password}" "${db_name}"
}

function set_db() {
  print_yellow "\n2. Config database"
  db_engine=$(get_config DB_ENGINE "mysql")
  db_host=$(get_config DB_HOST)

  case "${db_engine}" in
    mysql)
      confirm="n"
      if [[ "${db_host}" != "mysql" ]]; then
        confirm="y"
      fi
      read_from_input confirm "Do you want to use external MySQL?" "y/n" "${confirm}"
      if [[ "${confirm}" == "y" ]]; then
        set_external_db "mysql"
      else
        set_internal_db "mysql" "mysql" "3306" "smartdb"
      fi
      ;;
    *)
      echo "Invalid DB Engine selection"
      exit 1
      ;;
  esac
}

function set_external_redis() {
  redis_host=$(get_config REDIS_HOST)
  read_from_input redis_host "Please enter Redis server IP" "" "${redis_host}"
  if [[ "${redis_host}" == "127.0.0.1" || "${redis_host}" == "localhost" ]]; then
    print_error "$(gettext 'Can not use localhost as Redis server IP')"
  fi
  redis_port=$(get_config REDIS_PORT)
  read_from_input redis_port "Please enter Redis server port" "" "${redis_port}"
  redis_password=$(get_config REDIS_PASSWORD)
  read_from_input redis_password "Please enter Redis password" "" "${redis_password}"

  set_config REDIS_HOST "${redis_host}"
  set_config REDIS_PORT "${redis_port}"
  set_config REDIS_PASSWORD "${redis_password}"
}

function set_external_redis_sentinel() {
  redis_sentinel_hosts=$(get_config REDIS_SENTINEL_HOSTS)
  read_from_input redis_sentinel_hosts "Please enter Redis Sentinel hosts" "" "${redis_sentinel_hosts}"
  redis_sentinel_password=$(get_config REDIS_SENTINEL_PASSWORD)
  read_from_input redis_sentinel_password "Please enter Redis Sentinel password" "" "${redis_sentinel_password}"
  redis_password=$(get_config REDIS_PASSWORD)
  read_from_input redis_password "Please enter Redis password" "" "${redis_password}"

  disable_config REDIS_HOST
  disable_config REDIS_PORT
  set_config REDIS_SENTINEL_HOSTS "${redis_sentinel_hosts}"
  set_config REDIS_SENTINEL_PASSWORD "${redis_sentinel_password}"
  set_config REDIS_PASSWORD "${redis_password}"
}

function set_internal_redis() {
  redis_password=$(get_config REDIS_PASSWORD)
  if [[ -z "${redis_password}" ]]; then
    REDIS_PASSWORD=$(generate_random)
    set_config REDIS_PASSWORD "${REDIS_PASSWORD}"
  fi
  disable_config REDIS_SENTINEL_HOSTS
  disable_config REDIS_SENTINEL_PASSWORD
  set_config REDIS_HOST redis
  set_config REDIS_PORT 6379
}

function set_redis() {
  print_yellow "\n3. Config Redis"
  redis_engine="redis"
  read_from_input redis_engine "Please enter Redis Engine?" "redis/sentinel" "${redis_engine}"

  case "${redis_engine}" in
    redis)
        redis_host=$(get_config REDIS_HOST)
        confirm="n"
        if [[ "${redis_host}" != "redis" ]]; then
            confirm="y"
        fi
        read_from_input confirm "Do you want to use external Redis?" "y/n" "${confirm}"
        if [[ "${confirm}" == "y" ]]; then
            set_external_redis
        else
            set_internal_redis
        fi
        ;;
    sentinel)
        set_external_redis_sentinel
        ;;
    *)
        print_error "$(gettext 'Invalid Redis Engine selection')"
        ;;
  esac
}
function set_service() {
  print_yellow "\n4. $(gettext 'Config SmartDB service')"
  http_port=$(get_config HTTP_PORT)
  https_port=$(get_config HTTPS_PORT)

  confirm="n"
  read_from_input confirm "$(gettext 'Do you need to customize the SmartDB external http port, defualt is ')${http_port}?" "y/n" "${confirm}"
  if [[ "${confirm}" == "y" ]]; then
     read_from_input http_port "$(gettext 'SmartDB web http port')" "" "${http_port}"
     set_config HTTP_PORT "${http_port}"
  fi

  confirm="n"
  read_from_input confirm "$(gettext 'Do you need to customize the SmartDB external https port, defualt is ')${https_port}?" "y/n" "${confirm}"
  if [[ "${confirm}" == "y" ]]; then
    read_from_input https_port "$(gettext 'SmartDB web https port')" "" "${https_port}"
    set_config HTTPS_PORT "${https_port}"
  fi
  
  sed -i "s/HTTP_PORT/${http_port}/g" ${CONFIG_DIR}/nginx/smartdb.conf
  sed -i "s/HTTPS_PORT/${https_port}/g" ${CONFIG_DIR}/nginx/smartdb.conf
}

function main() {
  if set_data_dir; then
    print_done
  fi
  if set_db; then
    print_done
  fi
  if set_redis; then
    print_done
  fi
  if set_service; then
    print_done
  fi
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main
fi

