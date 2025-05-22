terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Configure your backend settings here
    # bucket = "your-terraform-state-bucket"
    # key    = "terraform.tfstate"
    # region = "your-region"
    # dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# VPC Data Source
data "aws_vpc" "selected" {
  id = var.vpc_id
}

# Data Lake Module
module "data_lake" {
  source = "./modules/data_lake"

  project_name = var.project_name
  environment  = var.environment
}

# EMR Module
module "emr" {
  source = "./modules/emr"

  project_name = var.project_name
  environment  = var.environment
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids
}

# Redshift Module
module "redshift" {
  source = "./modules/redshift"

  project_name = var.project_name
  environment  = var.environment
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids
} 