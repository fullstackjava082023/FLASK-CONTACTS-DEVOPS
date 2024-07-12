
echo "installation of docker"
# Set up Docker's apt repository.
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

#To install the latest version, run:
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Verify that the Docker Engine installation is successful by running the hello-world image.
sudo docker run hello-world
# enable docker (to start on boot)
sudo systemctl enable docker
echo "docker installation complete"

# Manage Docker as a non-root user
# To create the docker group and add your user:
sudo groupadd docker
# Add your user to the docker group.
sudo usermod -aG docker $USER

# Apply the new group membership without re-login
newgrp docker

# snap install kubectl --classic 
# kubectl version --client

# installation of kubernetes using apt-get
echo "installing kubectl"

# Update the apt package index and install packages needed to use the Kubernetes apt repository:
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

# Download the public signing key for the Kubernetes package repositories. 
# The same signing key is used for all repositories so you can disregard the version in the URL:
# If the folder `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring

# Add the appropriate Kubernetes apt repository.
#  If you want to use Kubernetes version different than v1.30,
#  replace v1.30 with the desired minor version in the command below:
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly


# Update apt package index, then install kubectl:
sudo apt-get update
sudo apt-get install -y kubectl



#####
####
###
# install minikube!!!
echo "installing minikube"
# # Update the package list:
# sudo apt-get update

# #Install conntrack:
# sudo apt-get install -y conntrack
# # Install crictl:
# VERSION="v1.30.1" # specify the version of crictl
# sudo curl -LO https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
# sudo tar -C /usr/local/bin -xzvf crictl-$VERSION-linux-amd64.tar.gz
# sudo rm crictl-$VERSION-linux-amd64.tar.gz


curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# start minikube
minikube start --driver=docker