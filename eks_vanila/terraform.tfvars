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
vpc_id = "vpc-4c2035b7a63ba69a8"
public_subnets = [
  "subnet-e67c471b59f9a4c6e",
  "subnet-825ed3806d9ef6d7f",
]
private_subnets = [
  "subnet-5aa80e0cb7e2e7626",
  "subnet-b68308cfe12601ba5"
]
pod_subnets = [
  "subnet-b78caa11abf8673ef",
  "subnet-cb4c1bbf9f6205dfb"
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