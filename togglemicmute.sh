#!/bin/bash

# Initialize a variable to track the microphone state
MIC_MUTED=false

SCRIPT_DIR=$(dirname "$0")

get_mic_status() {
    if wpctl status | grep -E -q "MUTED"; then
        MIC_MUTED=true
    else
        MIC_MUTED=false
    fi
}

# Function to toggle microphone mute/unmute
toggle_mic() {
    if $MIC_MUTED; then
        # Unmute the microphone
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
        aplay "${SCRIPT_DIR}/617288__drobin96__click-snap-sound.wav"
        MIC_MUTED=false
    else
        # Mute the microphone
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
        aplay "${SCRIPT_DIR}/536802__egomassive__switch.wav"
        MIC_MUTED=true
    fi
}

# Call the toggle_mic function
get_mic_status
toggle_mic

# Print the current microphone state
if $MIC_MUTED; then
    echo "Microphone is muted."
else
    echo "Microphone is unmuted."
fi
