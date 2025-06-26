output "role_arn" {
  description = "ARN of the IAM role for nodes"
  value       = aws_iam_role.eks_nodes_role.arn
}

output "role_id" {
  description = "ID of the IAM role for nodes"
  value       = aws_iam_role.eks_nodes_role.id
}

output "role_name" {
  description = "Name of the IAM role for nodes"
  value       = aws_iam_role.eks_nodes_role.name
}

output "instance_profile_arn" {
  description = "ARN of the instance profile for nodes"
  value       = aws_iam_instance_profile.nodes.arn
}

output "instance_profile_id" {
  description = "ID of the instance profile for nodes"
  value       = aws_iam_instance_profile.nodes.id
}

output "instance_profile_name" {
  description = "Name of the instance profile for nodes"
  value       = aws_iam_instance_profile.nodes.name
}

output "role_policy_attachments" {
  description = "List of IAM role policy attachments for nodes"
  value       = [
    aws_iam_role_policy_attachment.cni.policy_arn,
    aws_iam_role_policy_attachment.nodes.policy_arn,
    aws_iam_role_policy_attachment.ecr.policy_arn,
    aws_iam_role_policy_attachment.ssm.policy_arn,
    aws_iam_role_policy_attachment.cloudwatch.policy_arn
  ]
}