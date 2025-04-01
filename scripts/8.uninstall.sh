#!/usr/bin/env bash
# set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/utils.sh"

function stop_services() {
  docker compose version &>/dev/null || return
  if [[ -f "$CONFIG_ENV" ]]; then
    cd "${PROJECT_DIR?}" || exit 1
    bash ./smartdbcli.sh stop
    sleep 5s
    echo 
  fi
}

function delete_smartdbcli() {
  if check_root && [[ -f "/usr/bin/smartdbcli" ]]; then
    echo -e "rm /usr/bin/smartdbcli"
    rm -f /usr/bin/smartdbcli
  fi
}

function delete_smartdb() {
  if [ ! -f "${CONFIG_ENV}" ]; then
    return
  fi 
  echo 
  print_warn "Please sure you have saved the backup file, this operation will delete all data and then is irreversible!!! \n"
  print_yellow ">>> Delete SmartDB ..."
  images=$(get_images)
  volumes=$(get_config VOLUME_DIR)
  confirm="n"
  read_from_input confirm "Do you want to delete all data?" "y/n" "${confirm}"
  if [[ "${confirm}" == "y" ]]; then
    if [[ -d "${volumes}" ]]; then
      echo -e "rm -rf ${volumes}"
      rm -rf "${volumes?}"
    fi
    if [[ -d "${CONFIG_DIR}" ]]; then
      echo -e "rm -rf ${CONFIG_DIR}"
      rm -rf "${CONFIG_DIR?}"
      rm -f .env yml/.env
    fi
  fi
  confirm="n"
  read_from_input confirm "Do you want to delete all images? " "y/n" "${confirm}"
  if [[ "${confirm}" == "y" ]]; then
    if [[ -n "${images}" ]]; then
      for image in ${images}; do
        echo -e "docker rmi ${image}"
        docker rmi "${image?}"
      done
    fi
  fi
}

function delete_compose (){
  if check_root && [[ -f "/usr/local/libexec/docker/cli-plugins/docker-compose" ]]; then 
    echo
    confirm="n"
    read_from_input confirm "Do you want to delete docker-compose? " "y/n" "${confirm}"
    if [[ "${confirm}" == "y" ]]; then
      echo -e "rm /usr/local/libexec/docker/cli-plugins/docker-compose"
      rm -f /usr/local/libexec/docker/cli-plugins/docker-compose
    fi
  fi
  if [ -f "$HOME/.docker/cli-plugins/docker-compose" ]; then 
    echo
    confirm="n"
    read_from_input confirm "Do you want to delete docker-compose? " "y/n" "${confirm}"
    if [[ "${confirm}" == "y" ]]; then
      echo -e "rm $HOME/.docker/cli-plugins/docker-compose"
      rm -f $HOME/.docker/cli-plugins/docker-compose
    fi
  fi
}

function delete_docker() {
    if check_root && [ -f "/etc/systemd/system/docker.service" ]; then
    echo
    confirm="n"
    read_from_input confirm "$(gettext 'Do you want to delete docker')?" "y/n" "${confirm}"
    if [[ "${confirm}" == "y" ]]; then
      systemctl stop docker
      systemctl disable docker
      systemctl daemon-reload
      echo -e "rm /usr/local/bin/docker"
      rm -f /usr/local/bin/docker*
      rm -f /usr/local/bin/container*
      rm -f /usr/local/bin/ctr
      rm -f /usr/local/bin/runc
      echo -e "rm /etc/systemd/system/docker.service"
      rm -f /etc/systemd/system/docker.service
    fi
  fi
}

function uninstall() {
  stop_services
  delete_smartdbcli
  delete_smartdb
  delete_compose
  delete_docker
}

function main() {
  print_yellow ">>> Uninstall SmartDB ..."
  uninstall
  print_green ">>> Uninstall Done"
}

main
