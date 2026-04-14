#!/bin/sh

USER=${SUDO_USER:-$USER}

sudo -u $USER mkdir -p /home/$USER/.config/rc/runlevels/gui

# Install sway
apk add sway swaylock swaybg swayidle

# Install wayland
apk xwayland wl-clipboard

# Install font
apk add font-jetbrains-mono

# Install greeter
apk add greetd greetd-openrc greetd-agreety

# Install audio
apk add pipewire wireplumber pipewire-pulse

apk add dbus dbus-openrc seatd seatd-openrc xdg-utils xdg-desktop-portal-wlr xdg-desktop-portal-wlr-openrc

xdg-user-dirs-update

# config greetd
cat << EOF > /etc/conf.d/greetd
# Configuration for /etc/init.d/greetd

# Path to config file to use.
#cfgfile="/etc/greetd/config.toml"

rc_need=seatd
# Uncomment to use process supervisor.
# supervisor=supervise-daemon
EOF

cat << EOF > /etc/greetd/config.toml
[terminal]
# The VT to run the greeter on. Can be "next", "current" or a number
# designating the VT.
vt = 7

# The default session, also known as the greeter.
[default_session]

# agreety is the bundled agetty/login-lookalike. You can replace /bin/sh
# with whatever you want started, such as sway.
command = agreety --cmd "dbus-run-session sway"

# The user to run the command as. The privileges this user must have depends
# on the greeter. A graphical greeter may for example require the user to be
# in the video group.
user = "greetd"
EOF

adduser $USER seat
adduser greetd seat

rc-update add greetd
rc-update add seatd
rc-update add dbus

sudo -u $USER rc-update -U add xdg-desktop-portal-wlr gui
sudo -u $USER rc-update -U add pipewire gui
sudo -u $USER rc-update -U add wireplumber gui
sudo -u $USER rc-update -U add pipewire-pulse gui
