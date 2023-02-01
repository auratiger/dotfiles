#!/usr/bin/env bash

# Get the current audio device
current_device=$(playerctl -p spotify metadata --format '{{ playerName }}')

# Get a list of all active audio devices
devices=$(playerctl devices | awk '{print $1}')

# Set the next audio device to the first device in the list
next_device=$(echo "$devices" | head -n1)

# Find the current audio device in the list of devices
found=false
while read -r device; do
  if [[ $device == $current_device ]]; then
    found=true
  elif [[ $found == true ]]; then
    # Set the next audio device to the current device in the list
    next_device=$device
    break
  fi
done <<< "$devices"

# Change to the next audio device
playerctl --player="$next_device" play-pause
