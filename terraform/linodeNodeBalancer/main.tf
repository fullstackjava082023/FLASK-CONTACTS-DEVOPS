terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.25.0"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
    token = var.linode_token
}



resource "linode_instance" "web1" {
  label           = "web1"
  image           = "linode/ubuntu24.04"
  region          = "us-central"
  type            = "g6-nanode-1"
  authorized_keys = [var.ssh_key]
  root_pass       = var.root_pass
  private_ip = true
}

resource "linode_instance" "web2" {
  label           = "web2"
  image           = "linode/ubuntu24.04"
  region          = "us-central"
  type            = "g6-nanode-1"
  authorized_keys = [var.ssh_key]
  root_pass       = var.root_pass
   private_ip = true
}

resource "linode_nodebalancer" "lb" {
  region = "us-central"
}

resource "linode_nodebalancer_config" "lb_config" {
  nodebalancer_id = linode_nodebalancer.lb.id
  port            = 80
  protocol        = "http"
}

resource "linode_nodebalancer_node" "web1_node" {
  config_id     = linode_nodebalancer_config.lb_config.id
  nodebalancer_id = linode_nodebalancer.lb.id
  address       = "${linode_instance.web1.private_ip_address}:80"
  label         = "web1"
}

resource "linode_nodebalancer_node" "web2_node" {
  config_id     = linode_nodebalancer_config.lb_config.id
  nodebalancer_id = linode_nodebalancer.lb.id
  address       = "${linode_instance.web2.private_ip_address}:80"
  label         = "web2"
}


# Outputs
output "web1_ip" {
    value = {
        private_ip = linode_instance.web2.private_ip_address
        public_ip  = linode_instance.web2.ip_address
   } 
}

output "web2_ip" {
    value = {
        private_ip = linode_instance.web2.private_ip_address
        public_ip  = linode_instance.web2.ip_address
  }
}

output "lb_ip" {
  value = linode_nodebalancer.lb.ipv4
}