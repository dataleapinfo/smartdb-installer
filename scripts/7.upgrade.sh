#!/usr/bin/env bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BUILD_DIR}/utils.sh"
. "${BUILD_DIR}/1.install-docker.sh" 

PROJECT_DIR=$(dirname "${BUILD_DIR}")

target=$1

function check_and_set_config() {
  local config_key=$1
  local config_value=$2
  local current_value=$(get_config "${config_key}")
  if [ -z "${current_value}" ]; then
    set_config "${config_key}" "${config_value}"
  fi
}

function upgrade_config() {
  if check_root; then
    check_docker_start
  fi
  if ! docker ps &>/dev/null; then
    log_error "Docker is not running, please install and start"
    exit 1
  fi
  local containers=("dbagent_dbgatex_server" "dbagent_smartdata_admin" "dbagent_dbmanager" "dbagent_dbgatex_web" "dbagent_lb")
  for container in "${containers[@]}"; do
    if docker ps -a | grep ${container} &>/dev/null; then
      docker stop ${container} &>/dev/null
      docker rm ${container} &>/dev/null
    fi
  done
  check_and_set_config "CURRENT_VRESION" "${VERSION}" 
}

function stop_and_update_config() {
  pre_config
  upgrade_config
}

function backup_db() {
  if [[ "${SKIP_DB_BACKUP}" != "1" ]]; then
    if ! bash "${BUILD_DIR}/5.backup-db.sh"; then
      confirm="n"
      read_from_input confirm "Failed to backup database. Do you want to continue upgrade?" "y/n" "${confirm}"
      if [[ "${confirm}" == "n" ]]; then
        exit 1
      fi
    fi 
  else 
    echo "Skip database backup, SKIP_DB_BACKUP is set ${SKIP_DB_BACKUP}"
  fi
}

function backup_config() {
  VOLUME_DIR=$(get_config VOLUME_DIR)
  BACKUP_DIR="${VOLUME_DIR}/backup_db"
  CURR_VERSION=$(get_config CURR_VERSION)
  backup_config="${BACKUP_DIR}/config-${CURR_VERSION}-$(date +%Y%m%d%H%M%S).env"
  if [[ ! -d ${BACKUP_DIR} ]]; then
    mkdir -p ${BACKUP_DIR}
  fi
  cp "${CONFIG_ENV}" "${backup_config}"
  echo "Backup config to ${backup_config}"
}

function db_migratetions() {
  if docker ps | grep -E 'dbagent' &>/dev/null; then
    confirm="y"
    read_from_input confirm "Find that the DBAgent container is running, do you want to close the container and continue to upgrade?" "y/n" "${confirm}"
    if [[ "${confirm}" != "y" ]]; then
      echo 
      cd "${PROJECT_DIR}" || exit 1
      bash ./dbagentcli.sh stop
      sleep 5s
      echo
    else
      exit 1
    fi
  fi
  if ! exec_db_migrate; then
    echo_error "Failed to migrate database"
    confirm="n"
    read_from_input confirm "Failed to migrate database. Do you want to continue upgrade?" "y/n" "${confirm}"
    if [[ "${confirm}" != "y" ]]; then
      exit 1
    fi
  fi
}

function clean_images() {
  curr_version=$(get_curr_version)
  if [[ "${curr_version}" != "${to_version}" ]]; then
    old_images=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "dbagent/" | grep "${curr_version}")
    if [[ -n "${old_images}" ]] ; then
      confirm="y"
      read_from_input confirm "Find old images, do you want to clean them?" "y/n" "${confirm}"
      if [[ "${confirm}" == "y" ]]; then
        echo "${old_images}" | xargs docker rmi -f
        exit 1
      fi
    fi
  fi
}

function main() {
  confirm="y"
  to_version="${VERSION}"

  if [[ -n "${target}" ]]; then
    to_version="${target}"
  fi

  read_from_input confirm "Upgrade to version ${to_version}?" "y/n" "${confirm}"
  if [[ "${confirm}" != "y"  || -z "${to_version" ]]; then
    exit 3
  fi

  if [[ "${to_version}" && "${to_version}" != "${VERSION}" ]]; then
    sed -i "s@VERSION=.*@VERSION=${to_version}@g" "${PROJECT_DIR}/before_install.env"
    export VERSION="${to_version}"
  fi

  echo 
  stop_and_update_config
  check_compose_install
  echo 

  echo_yellow ">>>2. Loading images"
  bash "${BUILD_DIR}/2.load-images.sh"

  echo_yellow ">>>3. Backup database"
  backup_db

  echo_yellow ">>>4. Backup config file"
  backup_config

  echo_yellow ">>>5. Migrate database"
  echo "Change database may be wait a few minutes"
  db_migratetions

  echo_yellow ">>>6. Clean images"
  clean_images
  
  echo_success "Upgrade to version ${to_version} successfully, now restart the container"
  echo "cd ${PROJECT_DIR} && ./dbagentcli.sh start \n"
  set_curr_version
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main
fi
