#!/bin/bash

# Update package list and install necessary packages
sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-venv

# Verify installation
python3 --version
pip3 --version