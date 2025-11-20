#!/bin/bash

# Use the same wallpaper for dms and swww

wallpaper_bridge() {
    current_wallpaper=$(dms ipc call wallpaper get)
    swww img "$current_wallpaper"
}

if (( $# == 0 )); then
    wallpaper_bridge
    
elif (( $# == 1 )); then    
    case "$1" in
        prev)
            dms ipc call wallpaper prev
            ;;
        next)
            dms ipc call wallpaper next
            ;;
        *)
            echo "error: not a valid choice"
            exit 1
            ;;
    esac
    wallpaper_bridge
else
    echo "error: too much arguments"
    exit 1
fi
