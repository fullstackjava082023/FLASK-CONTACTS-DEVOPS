Vagrant.configure("2") do |config|
  # Set the boot timeout to 10 minutes (600 seconds)
  config.vm.boot_timeout = 600
  # First VM configuration
  config.vm.define "mysql_machine" do |mysql_machine|
    mysql_machine.vm.box = "ubuntu/jammy64" # Use "ubuntu/jammy64" for Ubuntu 22.04 LTS
    mysql_machine.vm.hostname = "mysqlMachine"  # Set your desired hostname here

    #  # Port forwarding
    # second.vm.network "forwarded_port", guest: 5052, host: 5052

    # Synced folder (optional)
    mysql_machine.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    # Provisioning script for MySQL setup
    mysql_machine.vm.provision "shell", path: "provisions/mysql-script.sh"

    # creation of the ip within the private network
    # note the range of private ips is :
    # The range of private IP addresses typically used in a private network is defined by the Internet Assigned Numbers Authority (IANA) as follows:
    # - Class A: 10.0.0.0 to 10.255.255.255
    # - Class B: 172.16.0.0 to 172.31.255.255
    # - Class C: 192.168.0.0 to 192.168.255.255
    mysql_machine.vm.network "private_network", ip: "192.168.33.20"
    

    mysql_machine.vm.provider "virtualbox" do |vb|
      # vb.gui = true
      vb.memory = "1024"
    end

    
  end

  #  Flask VM configuration
  config.vm.define "flask-vm" do |flask|
    flask.vm.box = "ubuntu/jammy64" # Use "ubuntu/jammy64" for Ubuntu 22.04 LTS
    flask.vm.hostname =   "flask-vm"  # Set your desired hostname here


    # Synced folder (optional)
    flask.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    # Provisioning scripts for setting up the VM, MySQL, Python pip and venv, and venv initialization
    #  flask.vm.provision "shell", name: "ubuntu-guest", path: "provisions/gui-and-guest-scripts.sh"
    #  flask.vm.provision "shell", name: "mysql-script", path: "provisions/mysql-script.sh"
    flask.vm.provision "shell", name: "python-pip-venv", path: "provisions/python-pip-venv.sh"
    #  flask.vm.provision "shell", name: "venv-init", path: "provisions/create-venv.sh"


    # Inline shell provisioner for running application setup commands
    flask.vm.provision "shell", name: "run", path: "provisions/run-app.sh", run: "always"

    flask.vm.network "private_network", ip: "192.168.33.10"

    # Enable the GUI
    flask.vm.provider "virtualbox" do |vb|
      # vb.gui = true
      vb.memory = "4096"
      vb.cpus = 2
    end

    # Port forwarding
    flask.vm.network "forwarded_port",host: 5053, guest: 5052


    # Enable drag and drop
    flask.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
  end
end
