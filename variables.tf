variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where resources will be created"
  type        = list(string)
}

# EMR Cluster Variables
variable "emr_cluster_name" {
  description = "Name of the EMR cluster"
  type        = string
  default     = "data-engineering-cluster"
}

variable "emr_release_label" {
  description = "EMR release label"
  type        = string
  default     = "emr-6.15.0"
}

variable "emr_instance_type" {
  description = "Instance type for EMR nodes"
  type        = string
  default     = "m5.xlarge"
}

# Redshift Variables
variable "redshift_cluster_identifier" {
  description = "Identifier for the Redshift cluster"
  type        = string
  default     = "data-warehouse"
}

variable "redshift_database_name" {
  description = "Name of the initial database in Redshift"
  type        = string
  default     = "analytics"
}

variable "redshift_master_username" {
  description = "Master username for Redshift"
  type        = string
  default     = "admin"
}

variable "redshift_node_type" {
  description = "Node type for Redshift cluster"
  type        = string
  default     = "dc2.large"
}

variable "redshift_number_of_nodes" {
  description = "Number of nodes in Redshift cluster"
  type        = number
  default     = 2
} 