output "cni_addon_arn" {
  description = "The ARN of the VPC CNI Addon"
  value       = aws_eks_addon.cni.arn
}

output "coredns_addon_arn" {
  description = "The ARN of the CoreDNS Addon"
  value       = aws_eks_addon.coredns.arn
}

output "kubeproxy_addon_arn" {
  description = "The ARN of the Kube-Proxy Addon"
  value       = aws_eks_addon.kubeproxy.arn
}

output "pod_identity_addon_arn" {
  description = "The ARN of the Pod Identity Addon"
  value       = aws_eks_addon.pod_identity.arn
}