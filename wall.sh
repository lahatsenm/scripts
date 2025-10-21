#!/usr/bin/bash

export WALL_DIR=~/wallpapers		# the directory in which the wallpapers are

# First, we need to list all the files in the wallpaper directory
# and store the result into an array
IFS=$'\n'
export WALL_ARR=($(ls $WALL_DIR))

# Next, get the length of the wallpaper array
IFS=$' \t\n'
export WALL_LENGTH=${#WALL_ARR[@]}

index=$(($RANDOM * $WALL_LENGTH / 32768))

export wallpaper=$(echo "$WALL_DIR/${WALL_ARR[$index]}")

swww img $wallpaper --transition-type random
