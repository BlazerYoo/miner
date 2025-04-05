#!/bin/bash

# Set variables for time and paths
XMR_SETUP_SCRIPT="$HOME/run_xmrig.sh"
CLEANUP_SCRIPT="$HOME/cleanup_xmrig.sh"
TERMINATE_TIME="21:30"

# Step 1: Run the XMR setup script (set this to run at 9:00 PM)
echo "Running XMR setup script..."
bash "$XMR_SETUP_SCRIPT"

# Step 2: Wait until 9:30 PM to terminate xmrig and clean up
echo "Waiting until 9:30 PM to terminate xmrig and clean up..."
while true; do
    current_time=$(date +%H:%M)
    if [ "$current_time" == "$TERMINATE_TIME" ]; then
        break
    fi
    sleep 10  # Check the time every 10 seconds
done

# Step 3: Terminate xmrig (if running)
echo "Terminating xmrig..."
pkill xmrig

# Step 4: Run cleanup script
echo "Running cleanup script..."
bash "$CLEANUP_SCRIPT"

# Step 5: Shut down the PC
echo "Shutting down the PC..."
sudo shutdown -h now
