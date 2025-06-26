project_name = "linuxtips-uncomplicating-eks"
region       = "us-east-1"
ssm_vpc      = "/linuxtips-uncomplicating-eks/vpc/id"

ssm_public_subnets = [
  "/linuxtips-uncomplicating-eks/subnets/public/us-east-1a/linuxtips-uncomplicating-eks-public-1a",
  "/linuxtips-uncomplicating-eks/subnets/public/us-east-1b/linuxtips-uncomplicating-eks-public-1b",
  "/linuxtips-uncomplicating-eks/subnets/public/us-east-1c/linuxtips-uncomplicating-eks-public-1c"
]

ssm_private_subnets = [
  "/linuxtips-uncomplicating-eks/subnets/private/us-east-1a/linuxtips-uncomplicating-eks-private-1a",
  "/linuxtips-uncomplicating-eks/subnets/private/us-east-1b/linuxtips-uncomplicating-eks-private-1b",
  "/linuxtips-uncomplicating-eks/subnets/private/us-east-1c/linuxtips-uncomplicating-eks-private-1c",
  "/linuxtips-uncomplicating-eks/subnets/database/us-east-1a/linuxtips-uncomplicating-eks-database-1a",
  "/linuxtips-uncomplicating-eks/subnets/database/us-east-1b/linuxtips-uncomplicating-eks-database-1b",
  "/linuxtips-uncomplicating-eks/subnets/database/us-east-1c/linuxtips-uncomplicating-eks-database-1c"
]

ssm_pod_subnets = [
  "/linuxtips-uncomplicating-eks/subnets/private/us-east-1a/linuxtips-uncomplicating-eks-pods-1a",
  "/linuxtips-uncomplicating-eks/subnets/private/us-east-1b/linuxtips-uncomplicating-eks-pods-1b",
  "/linuxtips-uncomplicating-eks/subnets/private/us-east-1c/linuxtips-uncomplicating-eks-pods-1c"
]

auto_scale_options = {
  min     = 2
  max     = 5
  desired = 3
}

nodes_instance_sizes = [
  "t3.large",
  "t3.large",
  "t3.large"
]