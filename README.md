# Terraform Backend Setup: S3 for State Storage & DynamoDB for Locking

## Overview

This Terraform configuration automates the setup of an S3 bucket for storing Terraform state and a DynamoDB table for managing state locking. Storing the state file remotely allows multiple users to collaborate on infrastructure, while the DynamoDB table prevents concurrent updates, ensuring the integrity of the state.

---

## Key Features
- **S3 Bucket for Terraform State**: Stores the Terraform state file, which tracks the infrastructure's current status.
- **DynamoDB Table for Locking**: Ensures no concurrent `terraform apply` or `terraform plan` commands modify the state, preventing conflicts.
- **Versioning**: S3 versioning is enabled to keep track of different versions of the Terraform state file.
- **Encryption**: Server-side encryption with AES256 ensures that the state file is securely stored in S3.
- **Access Control**: The S3 bucket is private, restricting access to authorized users only.

---

## Resources Created
1. **S3 Bucket**: Stores the Terraform state file with versioning and encryption.
2. **DynamoDB Table**: Used for locking the Terraform state to prevent simultaneous modifications.
3. **S3 Bucket Versioning**: Tracks all versions of the state file.
4. **S3 Server-Side Encryption**: Ensures the state file is encrypted using the AES256 algorithm.
5. **S3 Bucket ACL**: Ensures that the bucket is private.

---

## Folder Structure

```bash
terraform-backend-setup/
|-- main.tf                # Defines AWS resources such as S3 bucket and DynamoDB table
|-- variables.tf           # Contains all variable definitions (e.g., region, bucket name)
|-- outputs.tf             # Outputs for bucket and table names
```

---

## Usage

1. Clone the repository.
2. Configure your AWS credentials using the AWS CLI or environment variables.
3. Run `terraform init` to initialize the Terraform working directory.
4. Run `terraform apply` to provision the resources.

---

### Example Commands:

```bash
terraform init
terraform apply
```

---

### Sample of `backend.tf` file:

```hcl
terraform {
  backend "s3" {
    bucket         = var.bucket_name            # Name of the S3 bucket for state storage
    key            = "terraform/state.tfstate"  # Path within the S3 bucket where the state file will be stored
    region         = "us-east-1"                # The AWS region where your S3 bucket is located
    encrypt        = true                       # Enable encryption of the state file
    dynamodb_table = var.dynamodb_table_name    # DynamoDB table for state locking
  }
}
```