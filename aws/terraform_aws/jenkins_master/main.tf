provider "aws" {
  region = "us-east-1"
}

# Data source for existing Elastic IP
data "aws_eip" "existing_eip" {
  public_ip = "54.208.93.68"
}

resource "aws_instance" "jenkins_master" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  key_name      = "linuxED"
  
  subnet_id                  = "subnet-0cc3a39792ff6598a"
  vpc_security_group_ids     = ["sg-0a3a867d5d1a787e0"]
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins-Master"
  }

  

  provisioner "remote-exec" {
    inline = [ "sudo apt update" ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.aws/id_ed25519")
      host        = self.public_ip
    }
  
  }

  # Optional: Specify IAM instance profile if needed
  iam_instance_profile = "EC2-Admin"
  

  # Optional: Specify the boot mode if needed
  root_block_device {
    volume_size = 20 # specify the desired size if you are creating a new volume
    volume_type = "gp2"
  }
}

# Associate the Elastic IP with the EC2 instance
resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.jenkins_master.id
  public_ip = data.aws_eip.existing_eip.public_ip
}

output "IP" {
    value = aws_instance.jenkins_master.public_ip
}