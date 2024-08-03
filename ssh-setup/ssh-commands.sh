# Description: This file contains the commands to setup ssh keys
# check if .ssh directory exists
ls -la ~/.ssh

# show content of authorized_keys file
cat .ssh/authorized_keys

# search for the file called authorized_keys
find / -name authorized_keys

# generate ssh key pair with ed25519 algorithm save it in .ssh directory no passphrase
ssh-keygen -t ed25519 -C "default"
# accept defaults

# check that the key pair was generated
ls -la ~/.ssh

# we have private key id_ed25519 and public key id_ed25519.pub
# this is known as the public-private key pair
# you can share the public key with anyone
# you should never share the private key

# show the content of the public key
cat ~/.ssh/id_ed25519.pub

# show the content of the private key
cat ~/.ssh/id_ed25519

# now copy the public key to the remote server
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@172.232.193.165

# now you can ssh to the remote server without password
ssh root@172.232.206.211

# connect to the remote server using the private key specified file
ssh -i ~/.ssh/id_rsa2 root@172.232.206.211

# SSH configuration for Linode server
Host linode # this is the alias
    HostName 172.232.206.211 # this is the ip address
    User root # this is the username
    IdentityFile ~/.ssh/id_ed25519 # this is the private key file


# change the permissions of the private key
chmod 600 ~/.ssh/id_ed25519
