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

# install tmux package on all servers
ansible all -m apt -a name=tmux
# "changed": false = already installed

# update snapd package on all servers to the latest version
ansible all -m apt -a "name=snapd state=latest"

# install dist upgrade on all servers
# dist-upgraden 
# Command: sudo apt dist-upgrade
# Function: Also installs the latest versions of all currently installed packages on your system, but with more extensive capabilities.
# It is more aggressive than upgrade and can be used for system upgrades, such as moving to a new release of the distribution.
ansible all -m apt -a "upgrade=dist"

