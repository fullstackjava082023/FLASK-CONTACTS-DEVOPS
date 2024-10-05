provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# Create an IAM Policy for S3 Full Access
resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "S3FullAccessPolicy"
  description = "Policy to allow full access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = "*"
      }
    ]
  })
}

# Create an IAM Group
resource "aws_iam_group" "s3_access_group" {
  name = "S3AccessGroup"
}

# Attach the S3 Policy to the Group
resource "aws_iam_policy_attachment" "s3_policy_attachment" {
  name       = "S3PolicyAttachment"
  groups     = [aws_iam_group.s3_access_group.name]
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}

# (Optional) Create a user and add to the group
resource "aws_iam_user" "s3_user" {
  name = "S3User"
}

resource "aws_iam_user_group_membership" "s3_user_group_membership" {
  user   = aws_iam_user.s3_user.name
  groups = [aws_iam_group.s3_access_group.name]
}

# (Optional) Output the group and user information
output "group_name" {
  value = aws_iam_group.s3_access_group.name
}

output "user_name" {
  value = aws_iam_user.s3_user.name
}
