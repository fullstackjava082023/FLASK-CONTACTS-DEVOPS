Vagrant.configure("2") do |config|
  # Set the boot timeout to 10 minutes (600 seconds)
  config.vm.boot_timeout = 600
  # First VM configuration
  config.vm.define "desktop-for-tests2" do |desktop|
    desktop.vm.box = "aaronvonawesome/ubuntu-2404-cinnamon"# clean ubuntu with gui box
    # desktop.vm.box = "ubuntu/jammy64" #"ubuntu/bionic64" # Use "ubuntu/jammy64" for Ubuntu 22.04 LTS
    desktop.vm.hostname = "desktop-for-tests2"  # Set your desired hostname here

    # set boot timeout to 600 seconds
    desktop.vm.boot_timeout = 600
    # Provisioning script to set up the VM
    # desktop.vm.provision "shell", path: "provisions/gui-and-guest-scripts.sh"
    config.vm.provision "shell", inline: <<-SHELL
      # Change working directory to /vagrant
      cd /vagrant
    SHELL

    # Provisioning script for MySQL setup
    # desktop.vm.provision "shell", path: "provisions/mysql-script.sh"

    # Enable the GUI
    # Enable drag and drop
    desktop.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "2048"
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end

    # Synced folder (optional)
    desktop.vm.synced_folder ".", "/vagrant", type: "virtualbox"
   
   
  end

 
end
