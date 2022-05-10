#!/bin/bash

# Ensure apt has all available updates
apt update -y

# Upgrade all installed packages
apt upgrade -y

# Install new packages, and uninstall any old packages
apt full-upgrade -y

# Remove unused packages and their associated cfg files
apt autoremove --purge -y