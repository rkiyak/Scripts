#!/bin/bash

# Author: Rasit KIYAK
# Script to update and upgrade the system in check.sh

# Update package lists
echo "Updating package lists..."
sudo apt update

# Upgrade packages
echo "Upgrading packages..."
sudo apt upgrade -y

# Clean up unused packages
echo "Cleaning up unused packages..."
sudo apt autoremove -y

echo "Update and cleanup operations completed."