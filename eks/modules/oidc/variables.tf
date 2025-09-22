variable "aws_eks_cluster_issuer" {
  description = "The issuer URL of the OIDC provider for the EKS cluster"
  type        = string
  default     = "https://oidc.eks.<region>.amazonaws.com/id/<eks-cluster-id>"
}