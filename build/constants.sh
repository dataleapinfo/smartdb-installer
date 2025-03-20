#!/usr/bin/env bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BUILD_DIR}/.env"

export CACHE_DIR=~/.smartdb/cache
export DOWNLOAD_DIR=/home/download/smartdb

export DOCKER_VERSION=27.4.0
export DOCKER_MIRROR="https://mirrors.aliyun.com/docker-ce/linux/static/stable"

export DOCKER_COMPOSE_VERSION=v2.31.0
export DOCKER_COMPOSE_MIRROR="https://download.jumpserver.org/docker/compose/releases/download"

ARCH=$(uname -m)
if [ -n "${BUILD_ARCH}" ]; then
  ARCH=${BUILD_ARCH}
fi

export ARCH
export DOCKER_BIN_URL="${DOCKER_MIRROR}/${ARCH}/docker-${DOCKER_VERSION}.tgz"
export DOCKER_COMPOSE_BIN_URL="${DOCKER_COMPOSE_MIRROR}/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${ARCH}"
