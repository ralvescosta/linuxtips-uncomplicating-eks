resource "aws_subnet" "main" {
  count = length(var.subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.subnets[count.index].cidr
  availability_zone = var.subnets[count.index].az

  tags = {
    Name = var.subnets[count.index].name
  } 
}

resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.route_table_name
  } 
}

resource "aws_route" "main" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = var.route_destination_cidr
  gateway_id             = var.route_gateway_id

  depends_on = [aws_subnet.main, aws_route_table.main] 
}

resource "aws_route_table_association" "main" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.main.id

  depends_on = [aws_route.main]  
}