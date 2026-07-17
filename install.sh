#!/bin/sh

set -euo pipefail

ALPUSER=${SUDO_USER:-$USER}

## Prerequisites
setup-devd udev

### Install user programs
apk add librewolf foot foot-openrc helix grimshot mpv imv taplo rofi workstyle workstyle-openrc
install -Dm644 -o $ALPUSER -t /home/$ALPUSER/.config/rc/runlevels/gui \
  /etc/user/init.d/workstyle \
  /etc/user/init.d/foot

### Install graphics
apk add linux-firmware-amdgpu mesa mesa-dri-gallium mesa-va-gallium mesa-vulkan-ati
cat >/etc/modules <<EOF
af_packet
ipv6
amdgpu
fbcon
EOF
cat >/etc/mkinitfs/mkinitfs.conf <<EOF
features="keymap cryptsetup kms ata base ide scsi usb virtio ext4"
EOF
mkinitfs

### Install Sway
apk add sway swaylock swaybg swayidle xwayland wl-clipboard

### Install font
apk add font-jetbrains-mono

### Install audio
apk add pipewire wireplumber pipewire-pulse
install -Dm644 -o $ALPUSER -t /home/$ALPUSER/.config/rc/runlevels/gui \
  /etc/user/init.d/pipewire \
  /etc/user/init.d/pipewire-pulse \
  /etc/user/init.d/wireplumber

### Install firewall
apk add nftables
rc-update add nftables boot

### Install DBus
apk add dbus dbus-openrc
dbus-uuidgen --ensure
rc-update add dbus

### Install XDG
apk add xdg-user-dirs xdg-utils xdg-desktop-portal-wlr xdg-desktop-portal-wlr-openrc
install -Dm644 -o $ALPUSER -t /home/$ALPUSER/.config/rc/runlevels/gui \
  /etc/user/init.d/xdg-desktop-portal \
  /etc/user/init.d/xdg-desktop-portal-wlr
xdg-user-dirs-update

### Install greeter
apk add seatd seatd-openrc greetd greetd-openrc greetd-agreety
rc-update add seatd
rc-update add greetd
adduser $ALPUSER seat
adduser greetd seat
cat << EOF > /etc/conf.d/greetd
rc_need=seatd
# supervisor=supervise-daemon
EOF
cat << EOF > /etc/greetd/config.toml
[terminal]
vt = 7

[default_session]
command = agreety --cmd "dbus-run-session sway"
user = "greetd"
EOF
