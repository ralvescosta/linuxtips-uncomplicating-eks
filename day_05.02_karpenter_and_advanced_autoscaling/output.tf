output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "eks_certificate_authority" {
  value = module.eks.cluster_certificate_authority_data
}

output "eks_endpoint" {
  value = module.eks.cluster_endpoint
}