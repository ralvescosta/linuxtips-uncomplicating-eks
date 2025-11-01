variable "dns_name" {
  type        = string
  description = "The domain name for the ACM certificate"
}

variable "route53_zone_id" {
  type        = string
  description = "The Route 53 Hosted Zone ID for DNS validation"
}