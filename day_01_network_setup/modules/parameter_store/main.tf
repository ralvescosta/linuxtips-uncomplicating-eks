resource "aws_ssm_parameter" "vpc" {
  name = "/${var.project_name}/vpc/id"
  type = "String"
  value = var.vpc_id
}

resource "aws_ssm_parameter" "public_subnets" {
  count = length(var.public_subnets)

  name = "/${var.project_name}/subnets/public/${var.public_subnets[count.index].az}/${var.public_subnets[count.index].name}"
  type = "String"
  value = var.public_subnets[count.index].id
}

resource "aws_ssm_parameter" "private_subnets" {
  count = length(var.private_subnets)

  name = "/${var.project_name}/subnets/private/${var.private_subnets[count.index].az}/${var.private_subnets[count.index].name}"
  type = "String"
  value = var.private_subnets[count.index].id
}

resource "aws_ssm_parameter" "database_subnets" {
  count = length(var.database_subnets)

  name = "/${var.project_name}/subnets/database/${var.database_subnets[count.index].az}/${var.database_subnets[count.index].name}"
  type = "String"
  value = var.database_subnets[count.index].id
}