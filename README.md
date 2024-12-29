# Terraform Backend Setup

This repository automates the creation of an S3 bucket and a DynamoDB table for Terraform state management. The S3 bucket is used for storing Terraform state files, and the DynamoDB table is used for state locking to prevent concurrent modifications.

## Features
- **S3 Bucket**: Stores Terraform state with versioning and encryption.
- **DynamoDB Table**: Provides state locking to avoid conflicts.
- **GitHub Actions Workflow**: Allows you to deploy these resources directly from the GitHub UI by providing input parameters.

## File Structure
```plaintext
terraform-backend-setup/
|-- .github/
|   |-- workflows/
|       |-- terraform-deploy.yml  # GitHub Actions pipeline
|-- backend-setup.tf              # Terraform resources definition
|-- variables.tf                  # Terraform variables for customization
```

## How to Use

### Prerequisites
1. Ensure you have an AWS account with the necessary permissions to create S3 buckets and DynamoDB tables.
2. Store your AWS credentials securely.

### Steps
1. **Clone this repository**:
   ```bash
   git clone <repository-url>
   cd terraform-backend-setup
   ```

2. **Run the Workflow from GitHub**:
   - Navigate to the **Actions** tab in your GitHub repository.
   - Select the `Deploy Terraform Backend` workflow.
   - Click on **Run workflow**.
   - Provide the required inputs:
     - `bucket_name`: Name of the S3 bucket.
     - `table_name`: Name of the DynamoDB table.
     - `aws_access_key_id`: Your AWS access key ID.
     - `aws_secret_access_key`: Your AWS secret access key.
     - `aws_region`: AWS region (default: `us-east-1`).

3. **Verify Resources**:
   - Go to the AWS Management Console.
   - Check the S3 bucket and DynamoDB table created with the names you provided.

## Example Workflow Inputs
| Input Name           | Example Value               |
|----------------------|-----------------------------|
| `bucket_name`        | `my-terraform-state-bucket` |
| `table_name`         | `terraform-lock-table`      |
| `aws_access_key_id`  | `AKIA...`                   |
| `aws_secret_access_key` | `wJal...`               |
| `aws_region`         | `us-east-1`                |

## Notes
- This setup ensures secure and versioned storage of your Terraform state.
- DynamoDB provides robust state locking to prevent concurrent `apply` or `plan` operations.

## Cleanup
To delete the resources, run:
```bash
terraform destroy -var="bucket_name=<your-bucket-name>" -var="dynamodb_table_name=<your-table-name>" -var="region=<your-region>"
```