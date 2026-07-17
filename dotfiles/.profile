export WLR_DRM_DEVICES=/dev/dri/card1

export VK_KHR_surface=wayland
export VDPAU_DRIVER=radeonsi
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi

export TERM=foot
export BROWSER=librewolf
export GIT_EDITOR=hx

export RUSTC_WRAPPER=sccache 
export RUSTFLAGS="-Ctarget-feature=-crt-static -Zthreads=4 -Clink-arg=-fuse-ld=mold"

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
