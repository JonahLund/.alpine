#!/bin/sh
set -eu

ALPUSER=${ALPUSER:-${SUDO_USER:-$USER}}
ALPDIR=${ALPDIR:-/home/"$ALPUSER"/.alpine}
RC_GUI_DIR=${RC_GUI_DIR:-/home/"$ALPUSER"/.config/rc/runlevels/gui}

setup_apps() {
  apk add \
    librewolf \
    foot \
    tmux \
    helix \
    rustup \
    grimshot \
    mpv \
    imv \
    taplo \
    rofi \
    flatpak \
    prismlauncher

    sudo -u "$ALPUSER" sh -c <<EOF
rustup-init -y --default-toolchain nightly
. /home/"$ALPUSER"/.cargo/env
cargo install workstyle dotlink
dotlink --file "$ALPDIR"/dotlink.toml
EOF
}

setup_base() {
  setup-devd udev

  apk add \
    dbus \
    gcompat \
    mkrundir \
    xdg-user-dirs \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr \
    pciutils \
    nftables

  rc-update add dbus
  rc-update add nftables boot

  install -Dm644 -o "$ALPUSER" -g "$ALPUSER" -t "$RC_GUI_DIR" \
    /etc/user/init.d/xdg-desktop-portal \
    /etc/user/init.d/xdg-desktop-portal-wlr

  sudo -u "$ALPUSER" xdg-user-dirs-update
}

setup_graphics() {
  apk add \
    linux-firmware-amdgpu \
    mesa \
    mesa-dri-gallium \
    mesa-va-gallium \
    mesa-vulkan-ati

  cat >/etc/modules <<EOF
af_packet
ipv6
amdgpu
fbcon
EOF
}

setup_desktop() {
  apk add \
    sway \
    swaylock \
    swaybg \
    swayidle \
    xwayland \
    wl-clipboard \
    font-jetbrains-mono
}

setup_greeter() {
  apk add seatd greetd greetd-agreety

  cat >/etc/conf.d/greetd <<EOF
rc_need="seatd dbus"
EOF
  cat >/etc/greetd/config.toml <<EOF
[terminal]
vt = 7
[default_session]
command = agreety --cmd "dbus-run-session sway"
user = "greetd"
EOF

  adduser "$ALPUSER" seat
  addgroup greetd seat

  rc-update add seatd
  rc-update add greetd
}

setup_audio() {
  apk add \
    pipewire \
    wireplumber \
    pipewire-pulse \
    pipewire-alsa \
    pipewire-jack \
    rtkit

  install -Dm644 -o "$ALPUSER" -g "$ALPUSER" -t "$RC_GUI_DIR" \
    /etc/user/init.d/pipewire \
    /etc/user/init.d/pipewire-pulse \
    /etc/user/init.d/wireplumber

  rc-update add rtkit

  adduser "$ALPUSER" rtkit
}

setup_base
setup_graphics
setup_desktop
setup_audio
setup_apps
setup_greeter
