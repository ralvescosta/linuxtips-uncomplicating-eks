project_name   = "linuxtips-uncomplicating-eks"
region         = "us-east-1"
use_localstack = false

######## AWS
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
# ---
######## Localstack
# vpc_id = "vpc-3c3a314c9229194c7"
# public_subnets = [
#   "subnet-299f0e4d52ebfed38",
#   "subnet-41acb0949c7915a43",
# ]
# private_subnets = [
#   "subnet-eca9c6900a2a60fc7",
#   "subnet-bb4d30924e686bc25"
# ]
# pod_subnets = [
#   "subnet-388c8ec6d12e99707",
#   "subnet-6021543a36a2df7e3"
# ]
# addon_cni_version="v1.20.0-eksbuild.1"
# addon_coredns_version="v1.12.2-eksbuild.4"
# addon_kubeproxy_version="v1.33.0-eksbuild.2"
# addon_pod_identity_version="v1.3.8-eksbuild.2"
# ---

auto_scale_options = {
  min     = 2
  max     = 2
  desired = 2
}

nodes_instance_sizes = [
  "t3.medium",
  "t3.medium"
]