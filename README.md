# Terraform Data Engineering Infrastructure

This Terraform project manages the infrastructure for a data engineering environment. It sets up various AWS resources commonly used in data engineering workflows.

## Project Structure

```
.
├── README.md
├── main.tf           # Main Terraform configuration
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── terraform.tfvars  # Variable values
└── modules/         # Reusable modules
    ├── data_lake/   # S3 data lake configuration
    ├── emr/         # EMR cluster configuration
    └── redshift/    # Redshift cluster configuration
```

## Prerequisites

- Terraform >= 1.0.0
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions

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

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request 