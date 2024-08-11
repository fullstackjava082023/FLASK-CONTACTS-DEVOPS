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

resource "linode_volume" "example_volume" {
  label      = "example-volume-new"
  size       = 10
  region     = linode_instance.linodePC.region  # This ensures the volume is created in the same region as the instance
  linode_id  = linode_instance.linodePC.id      # This creates a dependency on the instance
}

resource "linode_instance" "linodePC" {
  label           = "simple_instance"
  image           = "linode/ubuntu24.04"
  region          = "us-central"
  type            = "g6-nanode-1"
  authorized_keys = [var.ssh_key]
  root_pass       = var.root_pass
  tags       = ["foo"]
}


output "instance_ip" {
  value = linode_instance.linodePC.ip_address
}

output "volume_id" {
  value = linode_volume.example_volume.id
}