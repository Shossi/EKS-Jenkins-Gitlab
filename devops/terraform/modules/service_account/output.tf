output "service_account_name" {
  description = "The name of the Kubernetes service account created"
  value       = kubernetes_service_account.cluster_autoscaler.metadata[0].name
}

output "iam_role_arn" {
  description = "The ARN of the IAM role created"
  value       = aws_iam_role.cluster_autoscaler_role.arn
}
