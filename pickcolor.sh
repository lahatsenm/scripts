#!/bin/bash

color=$(hyprpicker -a -f hex)
magick -size 64x64 xc:"$color" /tmp/color.png
notify-send -i /tmp/color.png "Hyprpicker" "Color: $color copied to clipboard"
