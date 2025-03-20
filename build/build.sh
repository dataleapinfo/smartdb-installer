#!/usr/bin/env bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

PROJECT_DIR=$(dirname "${BUILD_DIR}")

cd "${PROJECT_DIR}" || exit 1

. "${BUILD_DIR}/utils.sh"

function check_zst () {
  if ! command -v zstd &>/dev/null; then
    echo "zstd 未安裝，請先安裝 zstd (apt install zstd 或 yum install zstd)"
    exit 1
  fi
}

function main() {
  
  echo "[Start] SmartDB build..."
  echo "[VERSION] ${VERSION}"
  echo "[BUILD_DIR] ${BUILD_DIR}"
  
  check_zst
  bash "${BUILD_DIR}/pre_images.sh"
  bash "${BUILD_DIR}/release_online.sh"
  bash "${BUILD_DIR}/release_offline.sh"

  echo "[Done] SmartDB build completed"
  exit 0
}

main
