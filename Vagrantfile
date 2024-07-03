Vagrant.configure("2") do |config|
  # First VM configuration
  config.vm.define "desktop-for-tests" do |desktop|
    desktop.vm.box = "ubuntu/bionic64" # Use "ubuntu/jammy64" for Ubuntu 22.04 LTS
    desktop.vm.hostname = "desktop-for-tests"  # Set your desired hostname here

    # Provisioning script to set up the VM
    desktop.vm.provision "shell", path: "provisions/gui-and-guest-scripts.sh"

    # Provisioning script for MySQL setup
    desktop.vm.provision "shell", path: "provisions/mysql-script.sh"

    # Enable the GUI
    desktop.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "4096"
    end

    # Synced folder (optional)
    desktop.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    # Enable drag and drop
    desktop.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
  end

  # Second VM configuration
  config.vm.define "second-vm" do |second|
    second.vm.box = "ubuntu/jammy64" # Use "ubuntu/jammy64" for Ubuntu 22.04 LTS
    second.vm.hostname = "second-vm"  # Set your desired hostname here

    # Provisioning scripts for setting up the VM, MySQL, Python pip and venv, and venv initialization
    config.vm.provision "shell", name: "ubuntu-guest", path: "provisions/gui-and-guest-scripts.sh"
    config.vm.provision "shell", name: "mysql-script", path: "provisions/mysql-script.sh"
    config.vm.provision "shell", name: "python-pip-venv", path: "provisions/python-pip-venv.sh"
    config.vm.provision "shell", name: "venv-init", path: "provisions/create-venv.sh"


    # Inline shell provisioner for running application setup commands
    config.vm.provision "shell", name: "run", inline: <<-SHELL, run: "always"
      # Change working directory to /vagrant
      cd /vagrant
      # Install Python dependencies from requirements.txt
      pip3 install -r requirements.txt

      # Run migrations
      python3 migrate.py

      # Start the application
      python3 app.py
    SHELL

    # Enable the GUI
    second.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "4096"
      vb.cpus = 2
    end

    # Port forwarding
    second.vm.network "forwarded_port", guest: 5052, host: 5052

    # Synced folder (optional)
    second.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    # Enable drag and drop
    second.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
  end
end
