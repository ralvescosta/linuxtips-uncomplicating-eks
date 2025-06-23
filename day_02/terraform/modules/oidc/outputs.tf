output "oidc_provider_arn" {
  description = "The ARN of the OIDC provider for the EKS cluster"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_provider_url" {
  description = "The URL of the OIDC provider for the EKS cluster"
  value       = aws_iam_openid_connect_provider.eks.url
}

output "oidc_provider_client_ids" {
  description = "The client IDs for the OIDC provider"
  value       = aws_iam_openid_connect_provider.eks.client_id_list
}

output "oidc_provider_thumbprints" {
  description = "The thumbprints for the OIDC provider"
  value       = aws_iam_openid_connect_provider.eks.thumbprint_list
}

output "oidc_provider_certificate_fingerprint" {
  description = "The SHA1 fingerprint of the OIDC provider's certificate"
  value       = data.tls_certificate.eks.certificates[0].sha1_fingerprint
}

output "oidc_provider_certificate_subject" {
  description = "The subject of the OIDC provider's certificate"
  value       = data.tls_certificate.eks.certificates[0].subject
}

output "oidc_provider_certificate_issuer" {
  description = "The issuer of the OIDC provider's certificate"
  value       = data.tls_certificate.eks.certificates[0].issuer
}

output "oidc_provider_certificate_not_before" {
  description = "The not before date of the OIDC provider's certificate"
  value       = data.tls_certificate.eks.certificates[0].not_before
}

output "oidc_provider_certificate_not_after" {
  description = "The not after date of the OIDC provider's certificate"
  value       = data.tls_certificate.eks.certificates[0].not_after
}

output "oidc_provider_certificate_signature_algorithm" {
  description = "The signature algorithm of the OIDC provider's certificate"
  value       = data.tls_certificate.eks.certificates[0].signature_algorithm
}

output "oidc_provider_certificate_version" {
  description = "The version of the OIDC provider's certificate"
  value       = data.tls_certificate.eks.certificates[0].version
}