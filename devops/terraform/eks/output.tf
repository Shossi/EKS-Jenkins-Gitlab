output "eks_cluster_id" {
  description = "ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_auth" {
  value = module.eks.cluster_certificate_authority_data
}