# emacs-setup
This script automates the setup and configuration of Emacs, including updating submodules, installing Emacs and Mozc, setting up `.Xresources`, and managing `.emacs.d` directory backups.

## Overview

1. **Update Git Submodules**: Updates any submodules defined in the repository.
2. **Install Emacs**: Installs Emacs using Snap.
3. **Install Emacs Mozc**: Installs Mozc for Japanese input support.
4. **Configure `.Xresources`**: Ensures that the `UseXIM` setting is configured.
5. **Backup `.emacs.d`**: Backs up the existing `.emacs.d` directory if it exists.
6. **Copy New `.emacs.d`**: Copies the `.emacs.d` directory from the current location to the home directory.

## Requirements

- Ubuntu or Debian-based system.
- Snap package manager installed.
- Git for handling submodules.

## Script Execution

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/mugsimon/emacs-setup.git
   ```

2. **Run the Script**: Execute the script with the following command.
    ```bash
    cd emacs-setup
    chmod +x install.sh
    ```
    ```bash
    ./install.sh -i # make new .emacs.d
    ./install.sh -u # just update init.el
    ```

3. **Run Emacs**:
    ```bash
    emacs
    ```

## Notes
- **Initial Setup Time**: When you first start Emacs after running the installation script, there might be a delay due to the installation of required packages and setting up configurations. This process may take some time, especially when installing Emacs extensions and dependencies for the first time. Please be patient.
- **Backup**: If an existing .emacs.d directory is found, it will be backed up to the `~/backup` directory with a timestamp.
- **Warnings**: You might see several warnings when you start Emacs for the first time after installation. These warnings are typically related to package configurations and are not critical. They should not affect your Emacs experience. These warnings will not appear during subsequent startups once the initial setup is complete.
