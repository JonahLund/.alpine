export WLR_DRM_DEVICES=/dev/dri/card1
export XCURSOR_THEME=Adwaita

export VK_KHR_surface=wayland
export VDPAU_DRIVER=radeonsi
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi

export TERM=alacritty
export BROWSER=firefox

#export RUSTFLAGS=-Ctarget-feature=-crt-static
export RUSTC_WRAPPER=sccache 

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland

export PATH="$HOME/.yarn/bin:$PATH"

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

export HELIX_RUNTIME=/usr/lib/helix
