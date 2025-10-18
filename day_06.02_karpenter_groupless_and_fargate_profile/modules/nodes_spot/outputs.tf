output "group_id" {
  description = "ID of the EKS node group"
  value       = aws_eks_node_group.main.id
}

output "group_arn" {
  description = "ARN of the EKS node group"
  value       = aws_eks_node_group.main.arn
}

output "group_name" {
  description = "name of the eks node group"
  value       = aws_eks_node_group.main.node_group_name
}

# output "eks_node_group_autoscaling_name" {
#   description = "Name of the EKS node group autoscaling group"
#   value       = aws_eks_node_group.main.resources[0].autoscaling_groups[0].name
# }