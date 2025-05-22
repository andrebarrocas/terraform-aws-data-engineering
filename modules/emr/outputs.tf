output "cluster_id" {
  description = "ID of the EMR cluster"
  value       = aws_emr_cluster.cluster.id
}

output "master_public_dns" {
  description = "Public DNS name of the EMR master node"
  value       = aws_emr_cluster.cluster.master_public_dns
}

output "master_security_group_id" {
  description = "ID of the master node security group"
  value       = aws_security_group.emr_master.id
} 