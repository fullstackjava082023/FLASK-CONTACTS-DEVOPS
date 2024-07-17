Vagrant.configure("2") do |config|
  # Set the boot timeout to 10 minutes (600 seconds)
  config.vm.boot_timeout = 600
  # First VM configuration
  config.vm.define "cleanUbuntuJenkins" do |desktop|
    desktop.vm.box = "aaronvonawesome/ubuntu-2404-cinnamon"# clean ubuntu with gui box
    # desktop.vm.box = "ubuntu/jammy64" #"ubuntu/bionic64" # Use "ubuntu/jammy64" for Ubuntu 22.04 LTS
    desktop.vm.hostname = "cleanUbuntuJenkins"  # Set your desired hostname here

    # set boot timeout to 600 seconds
    desktop.vm.boot_timeout = 600
    # Provisioning script to set up the VM
    # desktop.vm.provision "shell", path: "provisions/gui-and-guest-scripts.sh"
    # config.vm.provision "shell", inline: <<-SHELL
    #   # Change working directory to /vagrant
    #   cd /vagrant
    # SHELL

    # Add port forwarding for port 8080
    config.vm.network "forwarded_port", guest: 8080, host: 8080

    # Add a private network with a specific IP address
    desktop.vm.network "private_network", ip: "192.168.33.10"

    # Provisioning script for jenkins installation
    desktop.vm.provision "shell", path: "provisions/install-jenkins.sh"
    # installing software needed for jinkins (docker kubectl)
    desktop.vm.provision "shell", path: "provisions/install-jenkins-sotware.sh"
    # starting mini kube on each boot
    # desktop.vm.provision "shell", inline: <<-SHELL, run: "always"
    #   # Other provisioning steps...
    #   minikube start --driver=docker --user=vagrant vagran
    #   # give permissions to the kubeconfig files
    #   sudo chmod -R +r /home/vagrant/.minikube/
    #   sudo chmod -R +r /home/vagrant/.kube/
    # SHELL

    

    # Enable the GUI
    # Enable drag and drop
    desktop.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "2048"
      vb.name = "JenkinsUbuntuVagrantBox" 
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end

    # Synced folder
    desktop.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    # desktop.vm.synced_folder "./kubeconfig", "/home/vagrant/.kube", type: "virtualbox"

    
   
   
  end

 
end
