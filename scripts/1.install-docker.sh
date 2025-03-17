#!/usr/bin/env bash
#
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/0.prepare.sh"

PROJECT_DIR=$(dirname "${BASE_DIR}")

DOCKER_CONFIG="/etc/docker/daemon.json"

cd "${BASE_DIR}" || exit 1

function copy_docker() {
  if [[ ! -d "/usr/local/bin" ]]; then
    mkdir -p /usr/local/bin
  fi
  tar --no-same-owner --strip-components=1 -xf "${PROJECT_DIR}/public/docker/docker.tar.gz" -C /usr/local/bin/ || {
    echo_red "$(gettext 'Failed to extract docker.tar.gz')"
    exit 1
  }
  \cp -f "${PROJECT_DIR}/public/docker/docker.service" /etc/systemd/system/
}

function install_docker() {
  if [[ ! -f ${PROJECT_DIR}/public/docker/docker.tar.gz ]]; then
    prepare_docker_bin
  fi
  if [[ ! -f ${PROJECT_DIR}/public/docker/docker.tar.gz ]]; then
    print_red "Error: $(gettext 'Docker program does not exist')"
    exit 1
  fi  
  if [[ ! -f "/usr/local/bin/dockerd" ]]; then
    copy_docker
  fi
}

function install_compose() {
  if [[ ! -f ${PROJECT_DIR}/public/docker/docker-compose ]]; then
    prepare_compose_bin
  fi
  if [[ ! -f "/usr/local/libexec/docker/cli-plugins/docker-compose" ]]; then
    if [[ ! -d "/usr/local/libexec/docker/cli-plugins" ]]; then
      mkdir -p /usr/local/libexec/docker/cli-plugins
    fi
    \cp -f ${PROJECT_DIR}/public/docker/docker-compose /usr/local/libexec/docker/cli-plugins/
  fi
}

function install_compose_home() {
  if [[ ! -f ${PROJECT_DIR}/public/docker/docker-compose ]]; then
    prepare_compose_bin
  fi
  if [[ ! -f "$HOME/.docker/cli-plugins/docker-compose" ]]; then
    if [[ ! -d "$HOME/.docker/cli-plugins" ]]; then
      mkdir -p $HOME/.docker/cli-plugins
    fi
    \cp -f ${PROJECT_DIR}/public/docker/docker-compose $HOME/.docker/cli-plugins/
  fi
}

function check_docker_install() {
  docker version &>/dev/null || {
    if check_root; then
      install_docker
    else
      print_warn "Permission denied..."
    fi
  }
}

function check_compose_install() {
  docker compose version &>/dev/null || {
    if check_root; then
      install_compose
    else
      install_compose_home
    fi
  }
  print_done
}

function set_docker_config() {
  key=$1
  value=$2

  if command -v python&>/dev/null; then
    docker_command=python
  elif command -v python2&>/dev/null; then
    docker_command=python2
  elif command -v python3&>/dev/null; then
    docker_command=python3
  else
    return
  fi

  if [[ ! -f "${DOCKER_CONFIG}" ]]; then
    config_dir=$(dirname ${DOCKER_CONFIG})
    if [[ ! -d ${config_dir} ]]; then
      mkdir -p "${config_dir}"
    fi
    echo -e "{\n}" >>${DOCKER_CONFIG}
  fi

"${docker_command}" -c "import json
key = '${key}'
value = '${value}'
try:
    value = json.loads(value)
except:
    pass
filepath = \"${DOCKER_CONFIG}\"
f = open(filepath);
config = json.load(f);
config[key] = value
f.close();
f = open(filepath, 'w');
json.dump(config, f, indent=True, sort_keys=True);
f.close()
"
}

function config_docker() {
  docker_storage_path=$(get_config DOCKER_DIR "/var/lib/docker")
  if [[ ! -d "${docker_storage_path}" ]]; then
    mkdir -p "${docker_storage_path}"
  fi

  set_docker_config live-restore "true"
  set_docker_config data-root "${docker_storage_path}"
  set_docker_config log-driver "json-file"
  set_docker_config log-opts '{"max-size": "10m", "max-file": "3"}'
}

function set_network() {
  # IPv6 支持
  use_ipv6=$(get_config USE_IPV6)
  confirm="n"
  if [[ "${use_ipv6}" == "1" ]]; then
    confirm="y"
  fi
  read_from_input confirm "$(gettext 'Do you want to support IPv6')?" "y/n" "${confirm}"
  if [[ "${confirm}" == "y" ]]; then
    set_docker_config ipv6 "true"
    set_docker_config fixed-cidr-v6 "fc00:1010:1111:100::/64"
    set_docker_config experimental "true"
    set_docker_config ip6tables "true"
    set_config USE_IPV6 1
  fi
}

function check_docker_config() {
  if check_root; then
    if [[ ! -f "/etc/docker/daemon.json" ]]; then
      config_docker
      set_network
    fi
    print_done
  else
    print_warn "Permission denied..."
  fi
}

function start_docker() {
  if command -v systemctl&>/dev/null; then
    systemctl daemon-reload
    systemctl enable docker
    systemctl start docker
  fi
  if ! docker ps &>/dev/null; then
    print_failed
    exit 1
  fi
}

function check_docker_start() {
  check_set_redhat_firewalld
  if ! docker ps &>/dev/null; then
    start_docker
  fi
}

function check_docker_compose() {
  if ! docker compose version &>/dev/null; then
    print_failed
    exit 1
  fi
  print_done
}

function main() {
  print_yellow "1. Install Docker"
  check_docker_install
  check_compose_install
  print_yellow "\n2. Configure Docker"
  check_docker_config
  print_yellow "\n3. Start Docker"
  check_docker_start
  check_docker_compose
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main
fi
