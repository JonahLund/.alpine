export XDG_RUNTIME_DIR=$(mkrundir)

export VDPAU_DRIVER=radeonsi
export LIBVA_DRIVER_NAME=radeonsi

export BROWSER=librewolf
export GIT_EDITOR=hx

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
