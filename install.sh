#!/bin/bash

# update .emacs.d
git submodule update

# update system package list
sudo apt update

# install Emacs
sudo snap install emacs --classic

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



