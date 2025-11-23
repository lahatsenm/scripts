#!/bin/bash

# It is recommended that this script be run
# while niri is not running; otherwise, the niri
# binary will not be copied.

niri_build="$HOME/pkg_sources/niri"

if [ -e "$niri_build" ]; then
    sudo cp --verbose $niri_build/target/release/niri /usr/bin/
    sudo cp --verbose $niri_build/resources/niri-session /usr/bin/
    sudo cp --verbose $niri_build/resources/niri.desktop /usr/share/wayland-sessions/
    sudo cp --verbose $niri_build/resources/niri-portals.conf /usr/share/xdg-desktop-portal/
    sudo cp --verbose $niri_build/resources/niri.service /etc/systemd/user/
    sudo cp --verbose $niri_build/resources/niri-shutdown.target /etc/systemd/user/
else
    echo "$niri_build: no such file or directory."
fi
