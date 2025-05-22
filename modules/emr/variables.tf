variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where EMR cluster will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where EMR cluster will be created"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EMR cluster"
  type        = string
  default     = "data-engineering-cluster"
}

variable "release_label" {
  description = "EMR release label"
  type        = string
  default     = "emr-6.15.0"
}

variable "instance_type" {
  description = "Instance type for EMR nodes"
  type        = string
  default     = "m5.xlarge"
} 