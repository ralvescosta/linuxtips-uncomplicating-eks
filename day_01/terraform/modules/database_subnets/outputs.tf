output "subnets_details" {
  description = "List of public subnet details"
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