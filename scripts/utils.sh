#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
. "${BASE_DIR}/constants.sh"

PROJECT_DIR=$(dirname "${BASE_DIR}")

BLUE='\033[0;34m' # Blue
NC='\033[0m' # No Color 

function print_banner() {
  cat <<"EOF"
 ____  ____       _                    _   
|  _ \| __ )     / \   __ _  ___ _ __ | |_ 
| | | |  _ \    / _ \ / _` |/ _ \ '_ \| __|
| |_| | |_) |  / ___ \ (_| |  __/ | | | |_ 
|____/|____/  /_/   \_\__, |\___|_| |_|\__|
                      |___/                
EOF
  echo
  echo -e "$BLUE $VERSION $NC "
  echo -e "$BLUE $COPYRIGHT $NC \n"
}

function read_from_input() {
  var=$1
  msg=$2
  choices=$3
  default=$4
  if [[ -n "${choices}" ]]; then
    msg="${msg} (${choices}) "
  fi
  if [[ -z "${default}" ]]; then
    msg="${msg} ($(gettext 'no default'))"
  else
    msg="${msg} ($(gettext 'default') ${default})"
  fi
  echo -n "${msg}: "
  read -r input
  if [[ -z "${input}" && -n "${default}" ]]; then
    export "${var}"="${default}"
  else
    export "${var}"="${input}"
  fi
}

function get_host_ip() {
  local default_ip="127.0.0.1"
  host=$(command -v hostname &>/dev/null && hostname -I | cut -d ' ' -f1)
  if [ ! "${host}" ]; then
      host=$(command -v ip &>/dev/null && ip addr | grep 'inet ' | grep -Ev '(127.0.0.1|inet6|docker)' | awk '{print $2}' | head -n 1 | cut -d / -f1)
  fi
  if [[ ${host} =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      echo "${host}"
  else
      echo "${default_ip}"
  fi
}

function check_root() {
  [[ "$(id -u)" -eq  0 ]]
}

function generate_random() {
  local length=${1:-16}
  tr -dc 'A-Za-z0-9' < /dev/urandom | head -c $length
}

function print_red() {
  echo -e "\033[1;31m$1\033[0m"
}

function print_green() {
  echo -e "\033[1;32m$1\033[0m"
}

function print_yellow() {
  echo -e "\033[1;33m$1\033[0m"
}

function print_done() {
  sleep 0.5
  echo "Completed."
}

function print_check() {
  echo -e "$1 \t [\033[32m √ \033[0m]"
}

function print_warn() {
  echo -e "[\033[33m WARNING \033[0m] $1"
}

function print_failed() {
  print_red "failed."
}

function print_success() {
  print_green "SUCCESS: $1"
}

function print_warn() {
  print_yellow "WARN: $1"
}

function print_error() {
  print_red "ERROR: $1"
}

function mkdir_if_not_exist() {
  if [[ ! -d "$1" ]]; then
    mkdir -p "$1"
  fi
}

function check_set_redhat_firewalld() {
  if command -v firewall-cmd&>/dev/null; then
    if firewall-cmd --state &>/dev/null; then
      docker_subnet=$(get_config DOCKER_SUBNET)
      if ! firewall-cmd --list-rich-rule | grep "${docker_subnet}"&>/dev/null; then
        firewall-cmd --zone=public --add-rich-rule="rule family=ipv4 source address=${docker_subnet} accept" >/dev/null
        firewall-cmd --permanent --zone=public --add-rich-rule="rule family=ipv4 source address=${docker_subnet} accept" >/dev/null
      fi
    fi
  fi
}

function get_config() {
  key=$1
  default=${2-''}
  value=$(grep "^${key}=" "${CONFIG_ENV}" | awk -F= '{ print $2 }' | awk -F' ' '{ print $1 }' | tail -1)
  if [[ -z "$value" ]];then
    value="$default"
  fi
  echo "${value}"
}

function has_config() {
  key=$1
  if grep "^[ \t]*${key}=" "${CONFIG_ENV}" &>/dev/null; then
    echo "1"
  else
    echo "0"
  fi
}

function set_config() {
  key=$1
  value=$2

  has=$(has_config "${key}")
  if [[ ${has} == "0" ]]; then
    echo "${key}=${value}" >>"${CONFIG_ENV}"
    return
  fi

  origin_value=$(get_config "${key}")
  if [[ "${value}" == "${origin_value}" ]]; then
    return
  fi

  sed -i "s,^[ \t]*${key}=.*$,${key}=${value},g" "${CONFIG_ENV}"
}

function pre_config() {
  cd "${PROJECT_DIR}" || exit 1
  if check_root; then
    echo -e "#!/usr/bin/env bash\n#" > /usr/bin/dbagentcli
    echo -e "cd ${PROJECT_DIR}" >> /usr/bin/dbagentcli
    echo -e './dbagentcli.sh $@' >> /usr/bin/dbagentcli
    chmod 755 /usr/bin/dbagentcli
  fi
  
  print_yellow "Please configure the environment variables in ${CONFIG_DIR}"
  print_yellow "1. Check config file"

  mkdir_if_not_exist "${CONFIG_DIR}"
  mkdir_if_not_exist "${CONFIG_DIR}/mysql"
  mkdir_if_not_exist "${CONFIG_DIR}/nginx"
  mkdir_if_not_exist "${CONFIG_DIR}/nginx/ssl"
  mkdir_if_not_exist "${CONFIG_DIR}/redis"
  mkdir_if_not_exist "${CONFIG_DIR}/admin"
  mkdir_if_not_exist "${CONFIG_DIR}/admin/license"

  if [[ ! -f "${CONFIG_ENV}" ]]; then
    cp before_install.env "${CONFIG_ENV}"
  else 
    print_check "${CONFIG_ENV}"
  fi
  if [[ ! -f ".env" ]]; then
    ln -s "${CONFIG_ENV}" .env
  fi

  if [[ ! -f "./yml/.env" ]]; then
    ln -s "${CONFIG_ENV}" ./yml/.env
  fi
  
  if [[ ! -f "${CONFIG_DIR}/mysql/my.cnf" ]]; then
    cp "${PROJECT_DIR}/config/mysql/my.cnf" "${CONFIG_DIR}/mysql/my.cnf"
  else 
    print_check "${CONFIG_DIR}/mysql/my.cnf"
  fi
  if [[ ! -f "${CONFIG_DIR}/nginx/default.conf" ]]; then
    cp "${PROJECT_DIR}/config/nginx/default.conf" "${CONFIG_DIR}/nginx/default.conf"
  else 
    print_check "${CONFIG_DIR}/nginx/default.conf"
  fi
  if [[ ! -f "${CONFIG_DIR}/nginx/ssl/server.crt" ]]; then
    cp "${PROJECT_DIR}/config/nginx/ssl/server.crt" "${CONFIG_DIR}/nginx/ssl/server.crt"
  else 
    print_check "${CONFIG_DIR}/nginx/ssl/server.crt"
  fi
  if [[ ! -f "${CONFIG_DIR}/nginx/ssl/server.key" ]]; then
    cp "${PROJECT_DIR}/config/nginx/ssl/server.key" "${CONFIG_DIR}/nginx/ssl/server.key"
  else 
    print_check "${CONFIG_DIR}/nginx/ssl/server.key"
  fi
  if [[ ! -f "${CONFIG_DIR}/redis/redis.conf" ]]; then
    cp "${PROJECT_DIR}/config/redis/redis.conf" "${CONFIG_DIR}/redis/redis.conf"
  else 
    print_check "${CONFIG_DIR}/redis/redis.conf"
  fi
  if [[ ! -f "${CONFIG_DIR}/admin/license/key.pem" ]]; then
    cp "${PROJECT_DIR}/config/admin/license/key.pem" "${CONFIG_DIR}/admin/license/key.pem"
    cp "${PROJECT_DIR}/config/admin/license/encrypted.dat" "${CONFIG_DIR}/admin/license/encrypted.dat"
    cp "${PROJECT_DIR}/config/admin/license/encrypted.signed" "${CONFIG_DIR}/admin/license/encrypted.signed"
  else 
    print_check "${CONFIG_DIR}/admin/license/key.pem"
  fi
  
  chmod 700 "${CONFIG_DIR}/.."
  find "${CONFIG_DIR}" -type d -exec chmod 700 {} \;
  find "${CONFIG_DIR}" -type f -exec chmod 600 {} \;
  chmod 644 "${CONFIG_DIR}/redis/redis.conf"
  chmod 644 "${CONFIG_DIR}/mysql/my.cnf"
  set_config CONFIG_DIR "${CONFIG_DIR}"
}

function disable_config() {
  key=$1

  has=$(has_config "${key}")
  if [[ ${has} == "1" ]]; then
    sed -i "s,^[ \t]*${key}=.*$,# ${key}=,g" "${CONFIG_FILE}"
  fi
}

set_curr_version() {
  curr_version=$(get_config CURR_VERSION)
  if [[ "${curr_version}" != "${VERSION}" ]]; then
    set_config CURR_VERSION "${VERSION}"
  fi
}

function get_curr_version() {
  curr_version=$(get_config CURR_VERSION "${VERSION}")
  echo "${curr_version}"
}

function get_latest_version() {
   curl -s 'https://api.github.com/repos/dataleapinfo/smartdb-installer/releases/latest' |
    grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' |
    sed 's/\"//g;s/,//g;s/ //g' 
}

function get_env_value() {
  key=$1
  default=${2-''}
  value="${!key}"
  echo "${value}"
}

function get_env() {
  key=$1
  value=''
  default=${2-''}
  if [[ -f "${CONFIG_ENV}" ]];then
    value=$(get_config "$key")
  fi

  if [[ -z "$value" ]];then
    value=$(get_env_value "$key")
  fi

  if [[ -z "$value" ]];then
    value="$default"
  fi
  echo "${value}"
}

function check_required_pkg() {
  for i in curl wget tar iptables; do
    command -v $i &>/dev/null || {
        print_red "$i: command not found, Please install it first $i"
        flag=1
    }
  done
  if [[ -n "$flag" ]]; then
    unset flag
    echo
    exit 1
  fi
}

function pull_image() {
  image=$1
  IMAGE_PULL_POLICY=$(get_env 'IMAGE_PULL_POLICY')

  if docker image inspect -f '{{ .Id }}' "$image" &>/dev/null; then
    exists=0
  else
    exists=1
  fi

  if [[ "$exists" == "0" && "$IMAGE_PULL_POLICY" != "Always" ]]; then
    echo "[${image}] exist, pass"
    return
  fi

  pull_args=""
  case "${BUILD_ARCH}" in
    "x86_64") pull_args="--platform linux/amd64" ;;
    "aarch64") pull_args="--platform linux/arm64" ;;
    "loongarch64") pull_args="--platform linux/loong64" ;;
    "s390x") pull_args="--platform linux/s390x" ;;
  esac

  echo "[${image}] pulling"
  full_image_path="${image}"
  if [[ -n "${REGISTRY}" ]]; then
    if ! echo "${image}" | grep -q "/";then
      app=$(echo "$image" | awk -F'/' '{ print $NF }')
      full_image_path="${REGISTRY}/${PUBLIC_IMAGE_PREFIX}/${app}"
    else
      full_image_path="${REGISTRY}/${image}"
    fi
  fi

  echo "[${full_image_path}] ..."
  if [[ "${full_image_path}" != "${image}" ]]; then
    echo "  -> [${full_image_path}]"
  fi
  docker pull ${pull_args} "${full_image_path}"
  if [[ "${full_image_path}" != "${image}" ]]; then
    docker tag "${full_image_path}" "${image}"
    docker rmi -f "${full_image_path}"
  fi
  echo ""
}

function get_images() {
  # db_images=$(get_db_images)
  images=(
    "redis:7.2-alpine3.18"
    "mysql:8.0.40-debian"
    "emqx:5.7"
    "nginx:1.25.3-alpine3.18"
  )
  for image in "${images[@]}"; do
    echo "${image}"
  done
    
  echo "smartdb/dbgatex-server:${VERSION}"
  echo "smartdb/dbgatex-web:${VERSION}"
  echo "smartdb/smartdata-admin:${VERSION}"
  echo "smartdb/dbmanager:${VERSION}"
}

function check_images() {
  images_to=$(get_images)
  failed=0

  for image in ${images_to}; do
    if ! docker image inspect -f '{{ .Id }}' "$image" &>/dev/null; then
      pull_image "$image"
    fi
  done
  for image in ${images_to}; do
    if ! docker image inspect -f '{{ .Id }}' "$image" &>/dev/null; then
      print_red "Failed to pull image ${image}"
      failed=1
    fi
  done

  if [ $failed -eq 1 ]; then
    exit 1
  fi
}


function pull_images() {
  images_to=$(get_images)
  pids=()

  trap 'kill ${pids[*]}' SIGINT SIGTERM

  for image in ${images_to}; do
    pull_image "$image" &
    pids+=($!)
  done
  wait ${pids[*]}

  trap - SIGINT SIGTERM

  check_images
}

function check_volume_dir() {
  volume_dir=$(get_config VOLUME_DIR)
  if [[ -d "${volume_dir}" ]]; then
    echo "1"
  else
    echo "0"
  fi
}

function check_db_data() {
  db_type=$1
  if [[ ! -f "${CONFIG_ENV}" ]]; then
    return
  fi
  volume_dir=$(get_config VOLUME_DIR)
  if [[ -d "${volume_dir}/${db_type}/data" ]]; then
    echo "1"
  else
    echo "0"
  fi
}

function get_db_info() {
  info_type=$1
  db_engine=$(get_config DB_ENGINE "mysql")
  db_host=$(get_config DB_HOST)
  check_volume_dir=$(check_volume_dir)
  if [[ "${check_volume_dir}" == "0" ]]; then
    db_engine=$(get_config DB_ENGINE "postgresql")
  fi

  mysql_data_exists="0"

  case "${db_engine}" in
    "mysql")
      if [[ "${db_host}" == "mysql" ]]; then
        mysql_data_exists=$(check_db_data "mysql")
      fi
      mariadb_data_exists="1"
      ;;
  esac

  case "${info_type}" in
    "image")
      if [[ "${mysql_data_exists}" == "1" ]]; then
        echo "mysql:8.0.40-debian"
      fi
      ;;
    "yml")
      if [[ "${mysql_data_exists}" == "1" ]]; then
        echo "yml/mysql.yml"
      fi
      ;;
    *)
      exit 1 ;;
  esac
}

function get_db_images() {
  get_db_info "image"
}

function get_db_images_yml() {
  get_db_info "yml"
}

function get_db_services() {
  services="mysql"

  echo "${services}"
}

function get_app_services() {
  services="dbmanager smartdata-admin dbgatex-server dbgatex-web mqtt nginx"
  is_buildin_db=$(get_config DB_HOST)
  if [[ "${is_buildin_db}" == "mysql" ]]; then
    services="mysql ${services}"
  fi

  if [[ "${is_buildin_db}" == "postgresql" ]]; then
    services="postgresql ${services}"
  fi
  is_buildin_redis=$(get_config REDIS_HOST)
  if [[ "${is_buildin_redis}" == "redis" ]]; then
    services="redis ${services}"
  fi

  echo "${services}"
}

function get_db_service_commands() {
  use_ipv6=$(get_config USE_IPV6)
  cmd="docker compose"
  services=$(get_db_services)
  # if [[ "${use_ipv6}" != "1" ]]; then
  #   cmd+=" -f yml/network.yml"
  # else
  #   cmd+=" -f yml/network-v6.yml"
  # fi

  for service in mysql redis; do
    if [[ "${services}" =~ ${service} ]]; then
      cmd+=" -f yml/${service}.yml"
    fi
  done

  echo "${cmd}"
}

function get_app_service_commands() {
  use_ipv6=$(get_config USE_IPV6)
  https_port=$(get_config HTTPS_PORT)
  cmd="docker compose"
  if [[ "${use_ipv6}" != "1" ]]; then
    cmd+=" -f yml/network.yml"
  else
    cmd+=" -f yml/network-v6.yml"
  fi
  services=$(get_app_services)

  for service in redis mysql postgresql mqtt nginx dbmanager smartdata-admin dbgatex-server dbgatex-web; do
    if [[ "${services}" =~ ${service} ]]; then
      cmd+=" -f yml/${service}.yml"
    fi
  done

  # if [[ -n "${https_port}" ]]; then
  #   cmd+=" -f yml/nginx.yml"
  # fi

  echo "${cmd}"
}

function get_service_name() {
  service=$1
  if [[ "${service:0:3}" != "dbagent" ]]; then
    service="dbagent_${service}"
  fi
  echo "${service}"
}

function get_file_md5() {
  file_path=$1
  if [[ -f "${file_path}" ]]; then
    if [[ "${OS}" == "Darwin" ]]; then
      md5 "${file_path}" | awk -F= '{ print $2 }'
    else
      md5sum "${file_path}" | awk '{ print $1 }'
    fi
  fi
}

function check_md5() {
  file=$1
  md5_should=$2

  md5=$(get_file_md5 "${file}")
  if [[ "${md5}" == "${md5_should}" ]]; then
    echo "1"
  else
    echo "0"
  fi
}

function get_db_migrate_cmd() {
  db_host=$(get_config DB_HOST)
  redis_host=$(get_config REDIS_HOST)
  use_ipv6=$(get_config USE_IPV6)

  cmd="docker compose "
  if [[ "${db_host}" == "mysql" ]]; then
    cmd+=" -f yml/mysql.yml"
  fi
  if [[ "${redis_host}" == "redis" ]]; then
    cmd+=" -f yml/redis.yml"
  fi

  if [[ "${use_ipv6}" != "1" ]]; then
    cmd+=" -f yml/network.yml"
  else
    cmd+=" -f yml/network-v6.yml"
  fi
  echo "$cmd"
}

function create_db_env() {
  cmd=$(get_db_migrate_cmd)
  ${cmd} up -d || {
    exit 1
  }
}

function create_db_database() {
  db_host=$(get_config DB_HOST)
  db_engine=$(get_config DB_ENGINE "mysql")
  db_password=$(get_config DB_PASSWORD)
  case "${db_host}" in
    "mysql")
      docker exec -i dbagent_mysql mysql -uroot -p"$db_password" < "${PROJECT_DIR}/sql/${db_engine}/smartdata.sql"
      ;;
  esac
}

function exec_db_migrate() {
  type=$1
  db_host=$(get_config DB_HOST)
  redis_host=$(get_config REDIS_HOST)
  db_password=$(get_config DB_PASSWORD)
  
  create_db_env
  case "${db_host}" in
    "mysql")
      while [[ "$(docker inspect -f '{{ .State.Health.Status }}' dbagent_${db_host})" != "healthy" ]]; do
        echo "Waiting for MySQL to be ready..."
        sleep 5
      done
      ;;
  esac
  case "${redis_host}" in
    "redis")
      while [[ "$(docker inspect -f '{{ .State.Health.Status }}' dbagent_${redis_host})" != "healthy" ]]; do
        echo "Waiting for Redis to be ready..."
        sleep 5
      done
      ;;
  esac
  sleep 20
  if [[ "${type}" == "init" ]]; then
    create_db_database || {
      echo "Failed to create database"
    }
  fi
  echo "Start database migrate"
  cmd="docker compose -f yml/init-db.yml"  
  ${cmd} up -d || {
    echo "Failed to start database migrate"
    docker logs $(${cmd} ps -q dbagent_init_db) 2>/dev/null
    ${cmd} down
    exit 1
  }

  while [[ "$(docker inspect -f '{{ .State.Health.Status }}' dbagent_init_db)" != "healthy" ]]; do
    echo "Waiting for database migrate to be ready..."
    sleep 5
  done
  print_green "Database migration completed successfully."
  ${cmd} down

  print_green "Database migrate done"
}

