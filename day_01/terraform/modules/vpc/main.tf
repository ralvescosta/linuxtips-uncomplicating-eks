resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = format("%s-%s", var.project_name, "vpc")
  } 
}

resource "aws_vpc_ipv4_cidr_block_association" "main" {
 count = length(var.vpc_additional_cidrs)

  vpc_id = aws_vpc.main.id
  cidr_block = var.vpc_additional_cidrs[count.index]
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s", var.project_name, "igw")
  } 
}
