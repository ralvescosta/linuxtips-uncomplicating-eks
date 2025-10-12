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
vpc_id = "vpc-bfa421d801350d6bc"
public_subnets = [
  "subnet-3e1f5075a5b416d8a",
  "subnet-6582273150b6befcc",
]
private_subnets = [
  "subnet-8c995819cc54276b4",
  "subnet-19c77f246dd5d7299"
]
pod_subnets = [
  "subnet-13b9bbb40fbc89496",
  "subnet-ac168bb77b77bd7db"
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