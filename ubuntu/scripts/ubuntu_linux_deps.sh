#!/bin/sh

# Script for common Dockerfile dependency installation in Ubuntu based images

set -ex
MACHINE=$(uname -m)

if grep -i "ubuntu" /etc/os-release >/dev/null; then

    if [ "${MACHINE}" = "aarch64" ]; then
        apt update && DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends git-all gcc-10 g++-10 curl
    fi
else
    echo "ERROR Unexpected distro"
    exit 1
fi

if [ -n "${CMAKE_VERSION}" ]; then
    curl -s -L https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-$(uname -m).tar.gz | tar -zx -C /usr --strip-components 1
fi

if [ -n "${GOLANG_VERSION}" ]; then
    GO_ARCH="arm64"
    mkdir -p /usr/local
    curl -s -L https://dl.google.com/go/go${GOLANG_VERSION}.linux-${GO_ARCH}.tar.gz | tar xz -C /usr/local
    ln -s /usr/local/go/bin/go /usr/local/bin/go
    ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
fi
