project_name   = "linuxtips-uncomplicating-eks"
region         = "us-east-1"
use_localstack = true

######## AWS
vpc_id = "vpc-834c31980b73300d4"
public_subnets = [
  "subnet-a7dbe8b819a3d98e3",
  "subnet-818035e112e0f4e91",
]
private_subnets = [
  "subnet-0c84b58e93d49c61c",
  "subnet-8552f776f262e240b"
]
pod_subnets = [
  "subnet-2843d7f0d72b838cf",
  "subnet-41d61a7c71cfa9eb9"
]
addon_cni_version="v1.20.0-eksbuild.1"
addon_coredns_version="v1.12.2-eksbuild.4"
addon_kubeproxy_version="v1.33.0-eksbuild.2"
addon_pod_identity_version="v1.3.8-eksbuild.2"

auto_scale_options = {
  min     = 2
  max     = 2
  desired = 2
}

nodes_instance_sizes = [
  "t3.medium",
  "t3.medium"
]
