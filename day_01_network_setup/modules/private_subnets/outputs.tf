output "subnets_details" {
  description = "List of private subnet details"
  value = [
    for i, subnet in aws_subnet.main : {
      id   = subnet.id
      arn  = subnet.arn
      name = subnet.tags["Name"]
      cidr = subnet.cidr_block
      az   = subnet.availability_zone
    }
  ]
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.main[*].id
}

output "route_table_ids" {
  description = "List of route table IDs for the private subnets"
  value       = aws_route_table.main[*].id
}

output "route_table_arns" {
  description = "List of route table ARNs for the private subnets"
  value       = aws_route_table.main[*].arn
}