#!/bin/sh

USER=${SUDO_USER:-$USER}

apk add rustup git tmux taplo iwe tmux-sessionizer

# sudo -u $USER "rustup-init -y --default-toolchain nightly"
