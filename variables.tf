variable "region" {
    description = "AWS region to deploy the resources."
    default     = "us-east-1"
}

variable "bucket_name" {
    description = "Unique S3 bucket name for Terraform state."
    type        = string
    default = "terraform-backend-bucket-ioioio10"
}

variable "dynamodb_table_name" {
    description = "DynamoDB table name for Terraform state locking."
    type        = string
    default = "state_locking"
}
