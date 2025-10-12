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
vpc_id = "vpc-e94e57a1c1f3b99af"
public_subnets = [
  "subnet-fac10b6df80e9a4bf",
  "subnet-b542ab291f6a3af1f",
]
private_subnets = [
  "subnet-915655d0992ebb547",
  "subnet-3ebc499177829f15c"
]
pod_subnets = [
  "subnet-46575818b1e0651ba",
  "subnet-69c3cf43a2afeed2d"
]
addon_cni_version="v1.20.0-eksbuild.1"
addon_coredns_version="v1.12.2-eksbuild.4"
addon_kubeproxy_version="v1.33.0-eksbuild.2"
addon_pod_identity_version="v1.3.8-eksbuild.2"
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