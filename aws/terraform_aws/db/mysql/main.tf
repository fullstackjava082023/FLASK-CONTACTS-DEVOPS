# Define the provider
provider "aws" {
  region = "us-east-1" 
}


# Security group to allow MySQL access (port 3306)
resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg"
  description = "Allow MySQL access"

  ingress {
    description = "MySQL Access"
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

# RDS MySQL instance
resource "aws_db_instance" "mysql" {
  identifier           = "my-custom-db-name"  # Specify your desired database name
  allocated_storage    = 20                     # Free tier allows up to 20 GB
  engine               = "mysql"                # Specify the DB engine
  engine_version       = "8.0"                  # Choose a free-tier eligible version
  instance_class       = "db.t4g.micro"         # Free-tier eligible instance type
  db_name              = "mydb2"                 # Database name
  username             = "root"                # Master username
  password             = "admin"         # Master password (ensure strong password)
  publicly_accessible  = true                   # Allow public access (adjust as needed)
  vpc_security_group_ids = [aws_security_group.rds_sg.id] # Attach the security group
  skip_final_snapshot  = true                   # Avoid final snapshot for demo purposes

  # Backup settings
  backup_retention_period = 7   # Retain backups for 7 days
  backup_window           = "07:00-09:00"

  # Free tier constraints
  storage_type         = "gp2"
  multi_az             = false # Free tier does not support Multi-AZ deployments
  max_allocated_storage = 100  # Auto-expand up to 100 GB
}

# Output the database endpoint
output "db_endpoint" {
  value = aws_db_instance.mysql.endpoint
  description = "The connection endpoint for the RDS MySQL instance."
}