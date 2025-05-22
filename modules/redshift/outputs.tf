output "cluster_endpoint" {
  description = "Endpoint of the Redshift cluster"
  value       = aws_redshift_cluster.main.endpoint
}

output "cluster_identifier" {
  description = "Identifier of the Redshift cluster"
  value       = aws_redshift_cluster.main.id
}

output "database_name" {
  description = "Name of the default database"
  value       = aws_redshift_cluster.main.database_name
}

output "connection_string" {
  description = "JDBC connection string for the Redshift cluster"
  value       = "jdbc:redshift://${aws_redshift_cluster.main.endpoint}/${aws_redshift_cluster.main.database_name}"
  sensitive   = true
}

output "master_username" {
  description = "Master username for the Redshift cluster"
  value       = aws_redshift_cluster.main.master_username
  sensitive   = true
}

output "master_password" {
  description = "Master password for the Redshift cluster"
  value       = random_password.master_password.result
  sensitive   = true
} 