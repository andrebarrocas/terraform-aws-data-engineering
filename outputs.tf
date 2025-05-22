output "data_lake_bucket_names" {
  description = "Names of the data lake S3 buckets"
  value       = module.data_lake.bucket_names
}

output "emr_cluster_id" {
  description = "ID of the EMR cluster"
  value       = module.emr.cluster_id
}

output "emr_master_public_dns" {
  description = "Public DNS of the EMR master node"
  value       = module.emr.master_public_dns
}

output "redshift_cluster_endpoint" {
  description = "Endpoint of the Redshift cluster"
  value       = module.redshift.cluster_endpoint
}

output "redshift_connection_string" {
  description = "JDBC connection string for Redshift"
  value       = module.redshift.connection_string
  sensitive   = true
} 