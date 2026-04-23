#!/bin/sh

ALPUSER=${SUDO_USER:-$USER}

apk add rustup git tmux taplo

# sudo -u $ALPUSER "rustup-init -y --default-toolchain nightly"
