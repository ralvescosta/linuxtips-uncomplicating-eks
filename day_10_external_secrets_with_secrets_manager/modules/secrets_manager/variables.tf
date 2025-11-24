variable "name" {
  description = "The name of the Secrets Manager secret"
  type        = string
}

variable "secret_string" {
  description = "The secret string to store in Secrets Manager"
  type        = string
}