export WLR_DRM_DEVICES=/dev/dri/card1

if [ -z "$XDG_RUNTIME_DIR" ]; then
	XDG_RUNTIME_DIR="/tmp/1000-runtime-dir"
	mkdir -pm 0700 $XDG_RUNTIME_DIR
	export XDG_RUNTIME_DIR
fi

export VK_KHR_surface=wayland
export VDPAU_DRIVER=radeonsi
export LIBVA_DRIVER_NAME=radeonsi
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi

export TERM=foot
export BROWSER=librewolf
export GIT_EDITOR=hx

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
