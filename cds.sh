#!/bin/bash

# Navigate through the directories
cd files || exit
cd ARDrone_SDK_2_0_1 || exit
cd Examples || exit
cd Linux || exit
cd Build || exit
cd Release || exit

# Start Xvfb if not already running
if ! pgrep Xvfb > /dev/null; then
    Xvfb :99 -screen 0 1024x768x16 &
    echo "Xvfb started"
else
    echo "Xvfb is already running"
fi

# Set the display environment variable
export DISPLAY=:99

# Run the ARDrone navigation program
#./ardrone_navigation

ps aux | grep Xvfb

# Navigate through the directories
cd files
cd ARDrone_SDK_2_0_1
cd Examples
cd Linux
cd Build
cd Release

Xvfb :99 -screen 0 1024x768x16 &
export DISPLAY=:99
ps aux | grep Xvfb
