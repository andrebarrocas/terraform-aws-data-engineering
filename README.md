# Terraform Data Engineering Infrastructure

This Terraform project manages the infrastructure for a data engineering environment. It sets up various AWS resources commonly used in data engineering workflows.

## Project Structure

```
.
├── README.md
├── main.tf           # Main Terraform configuration
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── terraform.tfvars  # Variable values (not committed)
├── terraform.tfvars.example  # Example variable values
└── modules/         # Reusable modules
    ├── data_lake/   # S3 data lake configuration
    ├── emr/         # EMR cluster configuration
    └── redshift/    # Redshift cluster configuration
```

## Prerequisites

- Terraform >= 1.0.0
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions

## Security Setup

1. Never commit `terraform.tfvars` to version control as it contains sensitive information
2. Copy `terraform.tfvars.example` to `terraform.tfvars` and update with your values:
```bash
cp terraform.tfvars.example terraform.tfvars
```
3. Update `terraform.tfvars` with your specific values:
   - AWS region
   - Environment name
   - Project name
   - VPC and subnet IDs
4. Keep your AWS credentials secure and never commit them to version control
5. Use AWS IAM best practices:
   - Use IAM roles with minimum required permissions
   - Regularly rotate access keys
   - Enable MFA for AWS users

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. To destroy the infrastructure:
```bash
terraform destroy
```

## Modules

### Data Lake
Creates an S3-based data lake with different zones (raw, processed, curated) and appropriate access policies.

### EMR Cluster
Sets up an EMR cluster for data processing with Spark and other big data tools.

### Redshift
Configures a Redshift cluster for data warehousing.

## Variables

Key variables that need to be set in `terraform.tfvars`:

- `aws_region`: AWS region to deploy resources
- `environment`: Environment name (e.g., dev, staging, prod)
- `project_name`: Name of your project
- `vpc_id`: VPC ID where resources will be created

## Security

- All sensitive data is encrypted at rest
- Network access is restricted through security groups
- IAM roles follow the principle of least privilege
- Sensitive variables are marked as sensitive in Terraform
- State files should be stored in a secure backend (e.g., S3 with encryption)

## State Management

It's recommended to store the Terraform state in a secure backend like S3 with:
- Encryption at rest
- Version control
- State locking (using DynamoDB)

Example S3 backend configuration (update `main.tf`):
```hcl
backend "s3" {
  bucket         = "your-terraform-state-bucket"
  key            = "terraform.tfstate"
  region         = "your-region"
  encrypt        = true
  dynamodb_table = "terraform-state-lock"
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes (excluding sensitive files)
4. Push to the branch
5. Create a Pull Request

## Security Best Practices

1. Never commit sensitive data:
   - AWS credentials
   - terraform.tfvars
   - .terraform directory
   - *.tfstate files
2. Use secure backends for state storage
3. Encrypt sensitive data at rest
4. Use proper IAM roles and policies
5. Regularly audit security groups and access policies 