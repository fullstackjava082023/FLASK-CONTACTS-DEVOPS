# Define the provider
provider "aws" {
  region = "us-east-1" 
}


# Security group to allow MySQL access (port 3306)
resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg"
  description = "Allow MySQL access"

  ingress {
    description = "DB Access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to the world (for demo purposes). Use specific IPs in production.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier = "aurora-cluster"
  engine             = "aurora-mysql"
  engine_mode        = "provisioned" # Can also use "serverless" for intermittent workloads
  database_name      = "mydatabase"
  master_username    = "admin"
  master_password    = "mypassword123"
  backup_retention_period = 1 # Set to 1 day to minimize cost
  preferred_backup_window  = "03:00-04:00"


  # Associate the RDS cluster with the security group
  vpc_security_group_ids   = [aws_security_group.rds_sg.id]
  

  storage_encrypted = true

  # Deletion protection off for dev/test environment
  deletion_protection = false

  tags = {
    Name = "Aurora-Cluster"
  }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  identifier        = "aurora-instance"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class    = "db.t4g.medium" # Small instance to minimize cost
  engine            = aws_rds_cluster.aurora.engine
  publicly_accessible = true

  tags = {
    Name = "Aurora-Instance"
  }
}

# Output the database endpoint
output "db_endpoint" {
  value = aws_rds_cluster_instance.aurora_instance.endpoint
  description = "The connection endpoint for the RDS aurora_instance."
}