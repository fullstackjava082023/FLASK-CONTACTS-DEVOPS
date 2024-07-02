# Update and upgrade
sudo apt-get update
sudo apt-get upgrade -y

# Install necessary packages for GUI and Guest Additions
sudo apt-get install -y ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Install additional packages for a smoother experience
sudo apt-get install -y build-essential dkms

# Restart the guest services
sudo systemctl restart vboxadd.service || true
# # Restart the VM
# sudo reboot