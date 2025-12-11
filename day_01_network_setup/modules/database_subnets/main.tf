resource "aws_subnet" "main" {
  count = length(var.database_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.database_subnets[count.index].cidr
  availability_zone = var.database_subnets[count.index].az

  tags = {
    Name = var.database_subnets[count.index].name
  }
}

# resource "aws_network_acl" "main" {
#   vpc_id = var.vpc_id

#   egress = {
#     rule_no    = 200
#     protocol   = "-1"
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port = 0
#     to_port   = 0
#   }

#   tags = {
#     Name = format("%s-database-nacl", var.project_name)
#   }
# }

# resource "aws_network_acl_rule" "deny" {
#   network_acl_id = aws_network_acl.main.id 

#   rule_number = "300"
#   rule_action = "deny"

#   protocol = "-1"
#   cidr_block = "0.0.0.0/0"
#   from_port = 0
#   to_port   = 0
# }