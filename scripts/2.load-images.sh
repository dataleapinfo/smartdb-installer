#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BASE_DIR}/utils.sh"

PROJECT_DIR=$(dirname "${BASE_DIR}")

cd "${BASE_DIR}" || return

IMAGE_DIR="${PROJECT_DIR}/images"

function load_image_files() {
  images=$(get_images)
  for image in ${images}; do
    filename=$(basename "${image}").tar.zst
    filename_windows=${filename/:/_}
    if [[ -f ${IMAGE_DIR}/${filename_windows} ]]; then
      filename=${filename_windows}
    fi
    if [[ ! -f ${IMAGE_DIR}/${filename} ]]; then
      print_red "$(gettext 'Docker image not found'): ${IMAGE_DIR}/${filename}"
      continue
    fi

    echo -n "${image} <= ${IMAGE_DIR}/${filename} "
    md5_filename=$(basename "${filename}").md5
    md5_path=${IMAGE_DIR}/${md5_filename}
    image_id=$(docker inspect -f "{{.ID}}" "${image}" 2&>/dev/null || echo "")
    hash_id=""

    if [[ -f "${md5_path}" ]]; then
      hash_id=$(cat "${md5_path}")
    fi
    if [[ ${image_id} != "${hash_id}" ]]; then
      echo
      docker load <"${IMAGE_DIR}/${filename}"
    else
      echo "$(gettext 'Docker image loaded, skipping')"
    fi
  done
}

function main() {
  if [[ -d "${IMAGE_DIR}" && $(find "${IMAGE_DIR}" -type f -name "*.zst" -print -quit 2>/dev/null) ]]; then
    load_image_files
  else
    pull_images
  fi
  print_done
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main
fi

