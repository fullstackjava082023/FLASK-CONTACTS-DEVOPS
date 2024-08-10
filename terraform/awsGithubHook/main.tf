terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change this to your desired region
}

# Define a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Define a subnet in the VPC
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet"
  }
}

# Define an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Define a Route Table and Route
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-route-table"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Security group to allow inbound traffic on port 5000 and SSH
resource "aws_security_group" "instance" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance-sg"
  }
}

# EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c0bfbb8624232a8e"  # Replace with the correct Ubuntu AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name = "key1"  # Ensure this key pair exists in AWS

  associate_public_ip_address = true

  tags = {
    Name = "example-instance"
  }
}

# Allocate an Elastic IP and associate it with the EC2 instance
resource "aws_eip" "example" {
  instance = aws_instance.example.id
}

# Output the Elastic IP address of the instance
output "instance_ip" {
  value = aws_eip.example.public_ip
}


# GitHub Provider Configuration
provider "github" {
  token = var.github_token
}

# Define a GitHub repository
resource "github_repository" "example" {
  name        = "example-repo"
  description = "A simple example repository"
  visibility = "public"
}

# Define a GitHub webhook
resource "github_repository_webhook" "example" {
  repository = github_repository.example.name
  
  active     = true
  events     = ["push", "pull_request"]

  configuration {
    url          = "https://54.208.93.68:5000"
    content_type = "json"
    insecure_ssl = false
  }
}