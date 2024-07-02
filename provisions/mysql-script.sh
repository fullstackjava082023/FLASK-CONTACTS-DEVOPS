#!/bin/bash

# Variables
MYSQL_ROOT_PASSWORD="admin"

# Install MySQL Server
sudo apt update
sudo apt install -y mysql-server

# Secure Installation Script
sudo mysql_secure_installation <<EOF

$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
y
y
y
EOF

# Change authentication method and set root password
sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

# Optional: Allow MySQL to listen on all interfaces (not recommended for production)
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL Service
sudo systemctl restart mysql

# Optional: Check MySQL Service Status
sudo systemctl status mysql

echo "MySQL installed and configured. Root password is set to: $MYSQL_ROOT_PASSWORD"
