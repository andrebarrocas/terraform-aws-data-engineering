variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where Redshift cluster will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where Redshift cluster will be created"
  type        = list(string)
}

variable "cluster_identifier" {
  description = "Identifier for the Redshift cluster"
  type        = string
}

variable "database_name" {
  description = "Name of the initial database"
  type        = string
  default     = "analytics"
}

variable "master_username" {
  description = "Master username for the Redshift cluster"
  type        = string
  default     = "admin"
}

variable "node_type" {
  description = "Node type for the Redshift cluster"
  type        = string
  default     = "dc2.large"
}

variable "number_of_nodes" {
  description = "Number of nodes in the Redshift cluster"
  type        = number
  default     = 2
} 