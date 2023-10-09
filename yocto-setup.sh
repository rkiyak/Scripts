#!/bin/bash

# Author: Rasit KIYAK
# This script helps you create a Debian-based distribution using the Yocto Project.

# Install required packages
sudo apt-get update
sudo apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping

# Download Yocto Project and navigate to the directory
mkdir ~/yocto
cd ~/yocto

# Clone the Yocto Project
git clone git://git.yoctoproject.org/poky.git
cd poky
git checkout dunfell  # Change this to your desired Yocto version

# Set up the environment
source oe-init-build-env

# Customize your build (e.g., choose image and package options)

# Build an image
bitbake core-image-minimal

# Retrieve the results
cp tmp/deploy/images/{machine}/core-image-minimal-{machine}.wic.gz ~/yocto-debian.wic.gz

echo "Debian-based Yocto Project created, and an image file 'yocto-debian.wic.gz' has been generated."
