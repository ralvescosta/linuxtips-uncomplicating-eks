project_name   = "linuxtips-uncomplicating-eks"
region         = "us-east-1"
use_localstack = true

######## AWS
# vpc_id = "vpc-03b22061d7648182a"
# public_subnets = [
#   "subnet-095401481eb512d9e",
#   "subnet-020dff4417a686247",
# ]
# private_subnets = [
#   "subnet-0cd10a3a924e77ace",
#   "subnet-030e5f523322c8b9f"
# ]
# pod_subnets = [
#   "subnet-06035a570ea949c58",
#   "subnet-07b28e126f5e958da"
# ]
# ---
######## Localstack
vpc_id = "vpc-c918ea52ba13fee51"
public_subnets = [
  "subnet-74a9306165148ba5d",
  "subnet-b5dceb871505ad5ba",
]
private_subnets = [
  "subnet-0dde2031a89f519d9",
  "subnet-31cefdd34d49ad914"
]
pod_subnets = [
  "subnet-b32c292e9244b7ed1",
  "subnet-2d4a7160eb5dfb8a5"
]
# ---

auto_scale_options = {
  min     = 2
  max     = 5
  desired = 3
}

nodes_instance_sizes = [
  "t3.medium",
  "t3.medium"
]