#!/bin/bash

echo "Installing prerequisites on Ubuntu..."

# Update package list and install tree
sudo apt-get update
sudo apt-get install -y tree

# Install terraform-docs
sudo snap install terraform-docs

# Install pylint
sudo apt-get install -y python3-pip
pip3 install pylint

echo "Installation completed."

exit 0
