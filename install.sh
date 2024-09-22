#!/bin/bash

# Function to display help
usage() {
    echo "Usage: $0 [-i | -u]"
    echo "  -i  Create a new .emacs.d directory and copy init.el"
    echo "  -u  Overwrite existing init.el with the new one"
    exit 1
}

# Parse options
while getopts "iu" opt; do
    case $opt in
        i)
            ACTION="install"
            ;;
        u)
            ACTION="update"
            ;;
        *)
            usage
            ;;
    esac
done

# Check if no options are provided
if [ -z "$ACTION" ]; then
    usage
fi

# Update .emacs.d submodule
git submodule update

# Handle actions
if [ "$ACTION" == "install" ]; then
    # Install Emacs
    sudo snap install emacs --classic

    # Update system package list
    sudo apt update

    # Install Emacs Mozc (for Japanese user)
    sudo apt install emacs-mozc-bin

    # Install markdown
    sudo apt-get install markdown

    # Install c/c++ completion dependencies
    sudo apt install clang
    sudo apt install cmake
    sudo apt install libclang-dev
    sudo apt install llvm-dev

    # Use C-space for mark set in Emacs
    CONFIG_LINE="Emacs*UseXIM: false"
    # Path to .Xresources
    XRESOURCES_FILE="$HOME/.Xresources"
    # Check file existence
    if [ -f "$XRESOURCES_FILE" ]; then
        # Check config line 
        if ! grep -Fxq "$CONFIG_LINE" "$XRESOURCES_FILE"; then
            # Add config line if not exist
            echo "$CONFIG_LINE" >> "$XRESOURCES_FILE"
            echo "Added setting: $CONFIG_LINE"
        else
            echo "Setting already exists."
        fi
    else
        # Create .Xresources
        echo "$CONFIG_LINE" > "$XRESOURCES_FILE"
        echo ".Xresources created and setting added."
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

    # Create .emacs.d directory and copy init.el
    mkdir -p "$HOME/.emacs.d"
    cp .emacs.d/init.el "$HOME/.emacs.d/init.el"
    echo "Copied init.el to $HOME/.emacs.d/init.el"

    # Copy .emacs.d directory
    # cp -r .emacs.d "$HOME"
    # echo "Copied .emacs.d to $HOME"

elif [ "$ACTION" == "update" ]; then
    # Overwrite existing init.el
    if [ -f "$HOME/.emacs.d/init.el" ]; then
        cp .emacs.d/init.el "$HOME/.emacs.d/init.el"
        echo "Overwritten init.el at $HOME/.emacs.d/init.el"
    else
        echo "No existing init.el found. Use -i to install it."
    fi
fi
