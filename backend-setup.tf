provider "aws" {
    region = var.region
}

# Create S3 Bucket for Terraform backend
resource "aws_s3_bucket" "terraform_state_backend" {
    bucket = var.bucket_name

    tags = {
        Name        = "Terraform State Backend"
        Environment = "dev"
    }
}

# Configure ownership controls (BucketOwnerEnforced)
resource "aws_s3_bucket_ownership_controls" "ownership" {
    bucket = aws_s3_bucket.terraform_state_backend.id

    rule {
        object_ownership = "BucketOwnerEnforced"
    }
}

# Configure server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
    bucket = aws_s3_bucket.terraform_state_backend.id

    rule {
        apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
        }
    }
}

# Configure versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.terraform_state_backend.id

    versioning_configuration {
        status = "Enabled"
    }
}

# Create DynamoDB Table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
    name         = var.dynamodb_table_name
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Name        = "Terraform Lock Table"
        Environment = "dev"
    }
}
