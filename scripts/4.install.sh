#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/utils.sh"

function check_docker() {
  if ! command -v systemctl &>/dev/null; then
    docker version &> /dev/null || {
      echo "$('Docker is not installed. Please install Docker first')"
      exit 1
    }
    docker compose version &> /dev/null || {
      echo "$( gettext 'Docker Compose is not installed. Please install Docker Compose first')"
      exit 1
    }
  fi
}

function post_install() {
  print_green "\n>>> Install completed."
  host=${get_host_ip}
  if [[ -z "${host}" ]]; then
    host="127.0.0.1"
  fi
  http_port=$(get_config HTTP_PORT)
  https_port=$(get_config HTTPS_PORT)
  server_name=$(get_config SERVER_NAME)
  
  print_yellow "$(gettext 'You can use the following command to start database and SmartDB and then visit')"
  echo "cd ${PROJECT_DIR}"
  print_green "\n1. First start the database ./smartdbcli.sh init_db"
  print_green "\n2. And then start SmartDB ./smartdbcli.sh start"

  echo "$(gettext 'For more commands, you can enter ./smartdbcli.sh --help to understand')"

  print_yellow "\n $(gettext 'Web access')"
  if [ -n "${server_name}" ] && [ -n "${https_port}" ]; then
    echo "https://${server_name}:${https_port}"
  else
    echo "http://${host}:${http_port}"
  fi

  echo "$(gettext 'Default username'): admin  $(gettext 'Default password'): 123123"

  print_yellow "\n $(gettext 'More information')"
  echo "$(gettext 'Official Website'): https://www.dataleapinfo.com"
  echo "$(gettext 'Documentation'): https://docs.dataleapinfo.com"
  echo -e "\n"
}

function main() {
  print_banner
  check_docker
  pre_config
  set_curr_version
  
  print_green "\n>>> Install and config docker."
  if ! bash "${BASE_DIR}/1.install-docker.sh"; then
    exit 1  
  fi
  
  print_green "\n>>> Loading docker images."
  if ! bash "${BASE_DIR}/2.load-images.sh"; then
    exit 1  
  fi
  
  print_green "\n>>> Deploy and config SmartDB."
  if ! bash "${BASE_DIR}/3.app-config.sh"; then
    exit 1  
  fi
  post_install
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main
fi
