provider "aws" {
  region = "us-east-1"
}


resource "aws_security_group" "ssh-access" {
    name        = "allow-ssh"
    description = "Allow SSH inbound traffic"
    
    ingress {
        description = "SSH from VPC"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
       
    }

    provisioner  "local-exec" {
        when = create
        command = "echo Security Group ${ aws_security_group.ssh-access.name } Created!  > tmp.txt"
       
    }
    provisioner  "local-exec" {
        when = destroy
        command = "echo Security Group ${ self.name } destroyed!  >> tmp.txt"
       
    }
  
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example AMI
  instance_type = "t2.micro"
  
  tags = {
    Name = "ExampleInstance"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.public_ip}, playbook.yml"
  }
}
