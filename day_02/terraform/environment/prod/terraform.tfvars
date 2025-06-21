project_name = "linuxtips-uncomplicating-eks"
region       = "us-east-1"
ssm_vpc      = "/linuxtips-uncomplicating-eks/vpc/id"
ssm_public_subnets = [
  "/linuxtips-uncomplicating-eks/vpc/public-subnet-1a",
  "/linuxtips-uncomplicating-eks/vpc/public-subnet-1b",
  "/linuxtips-uncomplicating-eks/vpc/public-subnet-1c"
]

ssm_private_subnets = [
  "/linuxtips-uncomplicating-eks/vpc/private-subnet-1a",
  "/linuxtips-uncomplicating-eks/vpc/private-subnet-1b",
  "/linuxtips-uncomplicating-eks/vpc/private-subnet-1c",
  "/linuxtips-uncomplicating-eks/vpc/pod-subnet-1a",
  "/linuxtips-uncomplicating-eks/vpc/pod-subnet-1b",
  "/linuxtips-uncomplicating-eks/vpc/pod-subnet-1c"
]

ssm_pod_subnets = [
  "/linuxtips-uncomplicating-eks/vpc/pod-subnet-1a",
  "/linuxtips-uncomplicating-eks/vpc/pod-subnet-1b",
  "/linuxtips-uncomplicating-eks/vpc/pod-subnet-1c"
]

auto_scale_options = {
  min     = 2
  max     = 5
  desired = 3
}

nodes_instance_sizes = [
  "t3.medium",
  "t3.large",
  "t3.xlarge"
]