output "eks_nodes_access_entry_id" {
  description = "The ID of the EKS nodes access entry"
  value       = aws_eks_access_entry.nodes.id
}

output "eks_nodes_access_entry_arn" {
  description = "The ARN of the EKS nodes access entry"
  value       = aws_eks_access_entry.nodes.arn
}

output "eks_nodes_access_entry_principal_arn" {
  description = "The principal ARN of the EKS nodes access entry"
  value       = aws_eks_access_entry.nodes.principal_arn
}

output "eks_nodes_access_entry_type" {
  description = "The type of the EKS nodes access entry"
  value       = aws_eks_access_entry.nodes.type
}

output "eks_nodes_access_entry_cluster_name" {
  description = "The name of the EKS cluster for the nodes access entry"
  value       = aws_eks_access_entry.nodes.cluster_name
}