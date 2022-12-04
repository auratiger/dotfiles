#!/bin/bash

# Grab a count of how many audio sinks we have
sink_count=$(pacmd list-sinks | grep -c "index:[[:space:]][[:digit:]]")
# Create an array of the actual sink IDs
sinks=()
mapfile -t sinks < <(pacmd list-sinks | grep 'index:[[:space:]][[:digit:]]' | sed -n -e 's/.*index:[[:space:]]\([[:digit:]]\)/\1/p')
# Get the ID of the active sink
active_sink=$(pacmd list-sinks | sed -n -e 's/[[:space:]]*\*[[:space:]]index:[[:space:]]\([[:digit:]]\)/\1/p')
# Get the ID of the last sink in the array
final_sink=${sinks[$((sink_count - 1 ))]}

# Find the index of the active sink
for index in "${!sinks[@]}"; do
  if [[ "${sinks[$index]}" == "$active_sink" ]]; then
    active_sink_index=$index
  fi
done

# Default to the first sink in the list
next_sink=${sinks[0]}
next_sink_index=0

# If we're not at the end of the list, move up the list
if [[ $active_sink -ne $final_sink ]] ; then
  next_sink_index=$(( active_sink_index + 1))
  next_sink=${sinks[$next_sink_index]}
fi

#change the default sink
pacmd "set-default-sink ${next_sink}"

#move all inputs to the new sink
for app in $(pacmd list-sink-inputs | sed -n -e 's/index:[[:space:]]\([[:digit:]]\)/\1/p');
do
  pacmd "move-sink-input $app $next_sink"
done

# Create a list of the sink descriptions
sink_descriptions=()
mapfile -t sink_descriptions < <(pacmd list-sinks | sed -n -e 's/.*alsa.name[[:space:]]=[[:space:]]"\(.*\)"/\1/p')
# Find the index that matches our new active sink
for sink_index in "${!sink_descriptions[@]}"; do
  if [[ "$sink_index" == "$next_sink_index" ]] ; then
    notify-send -i audio-volume-high "Sound output switched to ${sink_descriptions[$sink_index]}"
    exit
  fi
done
