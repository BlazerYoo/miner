#!/bin/bash

# Set variables
DOWNLOAD_URL="https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-noble-x64.tar.gz"
DEST_DIR="$HOME/Downloads"
TAR_NAME="xmrig-6.22.2-noble-x64.tar.gz"
EXTRACTED_FOLDER="xmrig-6.22.2"

# Step 1: Download the tar.gz file
echo "Downloading XMRig..."
wget -O "$DEST_DIR/$TAR_NAME" "$DOWNLOAD_URL"

# Step 2: Extract the tar.gz file
echo "Extracting..."
tar -xzf "$DEST_DIR/$TAR_NAME" -C "$DEST_DIR"

# Step 3: Replace config.json with the desired contents
CONFIG_JSON_PATH="$DEST_DIR/$EXTRACTED_FOLDER/config.json"
echo "Modifying config.json..."

cat > "$CONFIG_JSON_PATH" <<EOF
{
    "autosave": true,
    "cpu": true,
    "opencl": false,
    "cuda": true,
    "pools": [
        {
            "url": "pool.supportxmr.com:443",
            "user": "XMR_ADDRESS",
            "pass": "PC",
            "keepalive": true,
            "tls": true
        }
    ]
}
EOF

# Step 4: Run xmrig with sudo
echo "Running XMRig..."
cd "$DEST_DIR/$EXTRACTED_FOLDER"
sudo ./xmrig
