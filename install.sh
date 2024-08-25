#!/bin/bash

# update .emacs.d
git submodule update

# install Emacs
sudo snap install emacs --classic

# update system package list
sudo apt update

# install Emacs Mozc (for Japanese user)
sudo apt install emacs-mozc-bin

# Use C-space for mark set in Emacs
CONFIG_LINE="Emacs*UseXIM: false"
# Path to .Xresources
XRESOURCES_FILE="$HOME/.Xresources"
# Check file existance
if [ -f "$XRESOURCES_FILE" ]; then
    # Check config line 
    if ! grep -Fxq "$CONFIG_LINE" "$XRESOURCES_FILE"; then
        # Add config line if not exist
        echo "$CONFIG_LINE" >> "$XRESOURCES_FILE"
        echo "Add setting: $CONFIG_LINE"
    else
        echo "Setting already exist."
    fi
else
    # make .Xresources
    echo "$CONFIG_LINE" > "$XRESOURCES_FILE"
    echo ".Xresources made file, added setting."
fi

# Make backup if .emacs.d already exists
if [ -d "$HOME/.emacs.d" ]; then
    echo "Found .emacs.d, making backup..."
    BACKUP_DIR="$HOME/backup"
    # Create backup directory if it doesn't exist
    mkdir -p "$BACKUP_DIR"
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    mv "$HOME/.emacs.d" "$BACKUP_DIR/.emacs.d_$TIMESTAMP"
    echo ".emacs.d backed up to $BACKUP_DIR/.emacs.d_$TIMESTAMP"
fi

# Copy .emacs.d directory
cp -r .emacs.d "$HOME/.emacs.d"
echo ".emacs.d copied to $HOME/.emacs.d"
