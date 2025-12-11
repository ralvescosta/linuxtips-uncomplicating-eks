resource "aws_eip" "main" {
  count  = length(var.public_subnets)
  domain = "vpc"

  tags = {
    Name = format("%s-%s-%s", var.project_name, var.public_subnets[count.index].name, "eip")
  }
}

resource "aws_nat_gateway" "main" {
  count = length(var.public_subnets)

  allocation_id = aws_eip.main[count.index].id
  subnet_id     = var.public_subnets[count.index].id

  tags = {
    Name = format("%s-%s-%s", var.project_name, var.public_subnets[count.index].az, "nat-gtw")
  }

  depends_on = [aws_eip.main]
}

resource "aws_subnet" "main" {
  count = length(var.private_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets[count.index].cidr
  availability_zone = var.private_subnets[count.index].az

  tags = {
    Name = var.private_subnets[count.index].name
  }
}

resource "aws_route_table" "main" {
  count = length(var.private_subnets)

  vpc_id = var.vpc_id

  tags = {
    Name = format("%s-%s-%s", var.project_name, var.private_subnets[count.index].name, "rtb")
  }
}

resource "aws_route" "main" {
  count = length(var.private_subnets)

  route_table_id         = aws_route_table.main[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.main[
    index(
      var.public_subnets[*].az,
      var.private_subnets[count.index].az
    )
  ].id

  depends_on = [aws_subnet.main, aws_route_table.main]
}

resource "aws_route_table_association" "main" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.main[count.index].id

  depends_on = [aws_route.main]
}