# Define the provider
provider "aws" {
  region = "us-east-1" 
}


# # Security group to allow MySQL access (port 3306)
# resource "aws_security_group" "rds_sg" {
#   name        = "rds-mysql-sg"
#   description = "Allow MySQL access"

#   ingress {
#     description = "MySQL Access"
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Open to the world (for demo purposes). Use specific IPs in production.
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_dynamodb_table" "gotTable" {
  name = "gotTable" # Table name
  billing_mode = "PAY_PER_REQUEST" # On-demand pricing other option is PROVISIONED
  hash_key = "id" # Primary key
  attribute {
    name = "id" # Primary key
    type = "N" # Number other options include S (String), B (Binary)
  }  
}

resource "aws_dynamodb_table_item" "got-items" {
  table_name = aws_dynamodb_table.gotTable.name
  hash_key = aws_dynamodb_table.gotTable.hash_key
  item = <<EOF
    {
      "id": {"N": "1"},
      "name": {"S": "Jon Snow"},
      "house": {"S": "Stark"}
    }
  EOF
}



# Output the database endpoint
output "dynamo_db_info" {
  value = aws_dynamodb_table.gotTable.attribute
  description = "The connection endpoint for the RDS MySQL instance."
}

