terraform {
    backend "s3" {
        bucket = "devops-buckets-123-bucket01"
        key = "devops/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "state-locking"
    }
}





resource "local_file" "pet" {
    filename = "pets.txt"
    content = "We love petsss!!!"
}