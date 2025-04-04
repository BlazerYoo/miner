#!/bin/bash

# Define file and folder names
DEST_DIR="$HOME/Downloads"
TAR_NAME="xmrig-6.22.2-noble-x64.tar.gz"
EXTRACTED_FOLDER="xmrig-6.22.2"

# Delete the downloaded .tar.gz file
if [ -f "$DEST_DIR/$TAR_NAME" ]; then
    echo "Deleting $TAR_NAME..."
    rm "$DEST_DIR/$TAR_NAME"
else
    echo "$TAR_NAME not found."
fi

# Delete the extracted folder
if [ -d "$DEST_DIR/$EXTRACTED_FOLDER" ]; then
    echo "Deleting $EXTRACTED_FOLDER folder..."
    rm -rf "$DEST_DIR/$EXTRACTED_FOLDER"
else
    echo "$EXTRACTED_FOLDER folder not found."
fi

echo "Cleanup complete."
