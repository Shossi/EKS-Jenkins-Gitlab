output "cluster_endpoint" {
  description = "The endpoint for your EKS cluster"
  value       = module.k8s.eks_cluster_endpoint
}
output "cluster_certificate_auth" {
  value = module.k8s.cluster_auth
}
output "cluster_name" {
  value = module.k8s.cluster_name
}

output "eks_token" {
  value = data.aws_eks_cluster_auth.this.token
  sensitive = true
}