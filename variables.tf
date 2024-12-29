variable "region" {
  description = "AWS region to deploy the resources."
  type        = string
}

variable "bucket_name" {
  description = "Unique S3 bucket name for Terraform state."
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform state locking."
  type        = string
}
