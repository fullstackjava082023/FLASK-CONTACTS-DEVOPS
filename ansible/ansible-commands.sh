# ping to all servers in inventory use id_rsa2 key
ansible all -m ping -i inventory --key-file ~/.ssh/id_rsa2

# create default ansible.cfg file
ansible-config dump --only-changed > ansible2.cfg

# another way create config file
nano ansible.cfg
# # add the following content
# [defaults]
# inventory = inventory
# private_key_file = ~/.ssh/id_rsa2

# ping to all servers in inventory using the default from ansible.cfg
ansible all -m ping

# list all hosts in inventory
# ansible-inventory --list
ansible all --list-hosts

# show all facts 
ansible all -m gather_facts

# update cache for apt 
ansible all -m apt -a update_cache=yes
#the same command with elevated privileges
ansible all -m apt -a update_cache=yes --become --ask-become-pass

# install vim-nox package on all servers  --become --ask-become-pass
ansible all -m apt -a name=vim-nox

# check if vim-nox is installed on all servers
# inside the remote server
apt search vim-nox


# install tmux package on all servers
# tmux is a terminal multiplexer
ansible all -m apt -a name=tmux
# "changed": false = already installed

# update snapd package on all servers to the latest version
ansible all -m apt -a "name=snapd state=latest"

# copy file from /vagrant/ansible_lab/install_apache.yml to ~/ansible_lab/install_apache.yml force replace regular linux command
cp -f /vagrant/ansible-lab/install_apache.yml ~/ansible-lab/install_apache.yml
cp -f /vagrant/ansible-lab/inventory.ini ~/ansible-lab/inventory.ini
# copy file from /vagrant/ansible_lab/site.yml to ~/ansible_lab/site.yml force replace regular linux command
cp -f /vagrant/ansible-lab/site.yml ~/ansible-lab/site.yml
# copy all files from /vagrant/ansible_lab/ to ~/ansible_lab/ force replace regular linux command
cp -r --remove-destination /vagrant/ansible-lab/*  ~/ansible-lab/

#open port 80 to all servers by linux (not ansible) command centos ufw?
# open port 80 to all servers
sudo ufw allow 80



# install dist upgrade on all servers
# dist-upgraden 
# Command: sudo apt dist-upgrade
# Function: Also installs the latest versions of all currently installed packages on your system, but with more extensive capabilities.
# It is more aggressive than upgrade and can be used for system upgrades, such as moving to a new release of the distribution.
ansible all -m apt -a "upgrade=dist"

# checking users in the linux
ansible all -m shell -a "cat /etc/passwd" #  "cat /etc/passwd | cut -d: -f1"
# The string arja:x:1001:0::/home/arja:/bin/bash 
# arja: The username. This is the name of the user account.
# x: The password placeholder. Modern Unix systems use shadow passwords, so the actual password is stored in the /etc/shadow file. The x indicates that the password is in the shadow file.
# 1001: The user ID (UID). This is a unique number assigned to the user. User IDs typically start from 1000 for regular users.
# 0: The group ID (GID). This is the primary group ID associated with the user. 0 usually corresponds to the root group, which means this user is associated with the root group.
# `` (empty field): The GECOS field. It is typically used to store additional information about the user, such as their full name or contact details. In this case, it is empty.
# /home/arja: The home directory. This is the path to the user’s home directory, where personal files and configuration settings are stored.
# /bin/bash: The login shell. This is the path to the command-line shell that is started when the user logs in. In this case, it is /bin/bash, the Bourne Again Shell (bash).
