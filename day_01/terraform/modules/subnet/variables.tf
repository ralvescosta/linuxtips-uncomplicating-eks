variable "vpc_id" {
 type        = string
 description = "ID of the VPC to create the subnets in"
}

variable "subnets" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "List of subnets to create, each with a name and CIDR block"
}

variable "route_table_name" {
  type        = string
  description = "Name of the route table to create"
  default     = "default-route-table"
}

variable "route_destination_cidr" {
  type        = string
  description = "CIDR block for the route destination"
  default     = "0.0.0.0/0"
}

variable "route_gateway_id" {
  type        = string
  description = "ID of the gateway to route traffic to"
}