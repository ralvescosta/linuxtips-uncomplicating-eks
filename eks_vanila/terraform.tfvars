project_name   = "linuxtips-uncomplicating-eks"
region         = "us-east-1"
use_localstack = false

vpc_id = "vpc-03b22061d7648182a"

public_subnets = [
  "subnet-095401481eb512d9e",
  "subnet-020dff4417a686247",
]

private_subnets = [
  "subnet-0cd10a3a924e77ace",
  "subnet-030e5f523322c8b9f"
]

pod_subnets = [
  "subnet-06035a570ea949c58",
  "subnet-07b28e126f5e958da"
]

auto_scale_options = {
  min     = 2
  max     = 5
  desired = 3
}

nodes_instance_sizes = [
  "t3.micro",
  "t3.micro"
]