project_name   = "linuxtips-uncomplicating-eks"
region         = "us-east-1"
use_localstack = false

vpc_id = "vpc-0123456789abcdef0"

public_subnets = [
  "subnet-0a12345b6cdef7890",
  "subnet-1a12345b6cdef7890",
  "subnet-2a12345b6cdef7890"
]

private_subnets = [
  "subnet-0b12345b6cdef7890",
  "subnet-1b12345b6cdef7890",
  "subnet-2b12345b6cdef7890"
]

pod_subnets = [
  
]

auto_scale_options = {
  min     = 2
  max     = 5
  desired = 3
}

nodes_instance_sizes = [
  "t3.micro",
  "t3.micro",
  "t3.micro"
]