#!/bin/bash

# Function to display the volume notification with a progress bar
show_volume_notification() {
  local volume="$1"
  local volume_icon

  if [[ "$volume" == "muted" ]]; then
    volume_icon="audio-volume-muted"
    volume_percentage=0
  elif [[ "$volume" -le 10 ]]; then
    volume_icon="audio-volume-low"
    volume_percentage="$volume"
  elif [[ "$volume" -le 70 ]]; then
    volume_icon="audio-volume-medium"
    volume_percentage="$volume"
  else
    volume_icon="audio-volume-high"
    volume_percentage="$volume"
  fi

  # Construct the notification with dunstify.  The "value" option creates the progress bar.
  dunstify -a "Volume Control" -u normal -i "$volume_icon" \
           -r 51190 -t 2000 "Volume: $volume%" " " -h int:value:"$volume_percentage"
}
# Get current volume and mute status
get_volume() {
    local output
    output=$(amixer sget Master)

    # Check for mute status first.  This is important because if muted, the percentage will
    # still be reported by amixer, but we want to show it as "muted".
    if echo "$output" | grep -q "\[off\]"; then
        echo "muted"
    else
        # Extract volume percentage. The sed command handles both mono and stereo outputs.
        echo "$output" | grep -oP '\[\K[0-9]+(?=%\])' | head -n 1
    fi
}

# --- Main script logic ---

case "$1" in
  up)
    amixer sset Master 5%+ &> /dev/null
    volume=$(get_volume)
    show_volume_notification "$volume"
    ;;
  down)
    amixer sset Master 5%- &> /dev/null
    volume=$(get_volume)
    show_volume_notification "$volume"
    ;;
  mute)
    amixer sset Master toggle &> /dev/null
    volume=$(get_volume)
    show_volume_notification "$volume"
    ;;
  show)
    volume=$(get_volume)
    show_volume_notification "$volume"
    ;;
  *)
    echo "Usage: $0 {up|down|mute|show}"
    exit 1
    ;;
esac

exit 0
