#!/usr/bin/env bash
#
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/utils.sh"

PROJECT_DIR=$(dirname "${BASE_DIR}")

IMAGE_DIR="${PROJECT_DIR}/images"

function download_and_verify() {
  local url=$1
  local target_path=$2
  local md5_target_path="${target_path}.md5"

  parent_dir=$(dirname "${target_path}")
  if [[ ! -d "${parent_dir}" ]]; then
    mkdir -p "${parent_dir}"
  fi

  check_required_pkg
  if [[ ! -f "${md5_target_path}" ]]; then
    echo "Starting to download: ${url}.md5"
    wget -q "${url}.md5" -O "${md5_target_path}" || {
      print_error "Download fails, check the network is normal"
      rm -f "${md5_target_path}"
      exit 1
    }
  else
    echo "Using cache: ${md5_target_path}"
  fi

  expected_md5=$(cut -d ' ' -f1 "${md5_target_path}")
  md5_matched=$(check_md5 "${target_path}" "${expected_md5}")
  if [[ ! -f "${target_path}" || "${md5_matched}" != "1" ]]; then
    echo "Starting to download: ${url}"
    wget -q "${url}" -O "${target_path}" || {
      print_error "Download fails, check the network is normal"
      rm -f "${target_path}" "${md5_target_path}"
      exit 1
    }
  else
    echo "Using cache: ${target_path}"
  fi
}

function download() {
  local url=$1
  local target_path=$2

  parent_dir=$(dirname "${target_path}")
  if [[ ! -d "${parent_dir}" ]]; then
    mkdir -p "${parent_dir}"
  fi

  check_required_pkg

  if [[ ! -f "${target_path}" ]]; then
    echo "Starting to download: ${url}"
    wget -q "${url}" -O "${target_path}" || {
      print_error "Download fails, check the network is normal"
      rm -f "${target_path}"
      exit 1
    }
  else
    echo "Using cache: ${target_path}"
  fi
}

function prepare_docker_bin() {
  download "${DOCKER_BIN_URL}" "${PROJECT_DIR}/public/docker/docker.tar.gz"
}

function prepare_compose_bin() {
  download_and_verify "${DOCKER_COMPOSE_BIN_URL}" "${PROJECT_DIR}/public/docker/docker-compose"
  chown -R root:root "${PROJECT_DIR}/public/docker/docker-compose"
  chmod +x "${PROJECT_DIR}/public/docker/docker-compose"
}

function prepare_image_files() {
  if ! pgrep -f "docker"&>/dev/null; then
    echo "Docker is not running, please install and start ..."
    exit 1
  fi
  pull_images

  images=$(get_images)
  for image in ${images}; do
    filename=$(basename "${image}").zst
    image_path="${IMAGE_DIR}/${filename}"
    md5_filename=$(basename "${image}").md5
    md5_path="${IMAGE_DIR}/${md5_filename}"

    image_id=$(docker inspect -f "{{.ID}}" "${image}")
    saved_id=""
    if [[ -f "${md5_path}" ]]; then
      saved_id=$(cat "${md5_path}")
    fi

    if [[ ! -d "${IMAGE_DIR}" ]]; then
      mkdir -p "${IMAGE_DIR}"
    fi

    if [[ -f "${image_path}" ]]; then
      if [[ "${image_id}" != "${saved_id}" ]]; then
        rm -f "${image_path}" "${md5_path}"
      else
        echo "The image has been saved, skipping: ${image}"
        continue
      fi
    fi
    echo "Save image ${image} -> ${image_path}"
    docker save "${image}" | zstd -f -q -o "${image_path}" &
    echo "${image_id}" >"${md5_path}" &
  done
  wait
}

function main() {
  check_required_pkg

  echo 'Preparing Docker offline package'
  echo
  time prepare_docker_bin
  time prepare_compose_bin

  echo 'Preparing image offline package'
  echo
  time prepare_image_files
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main 
fi


