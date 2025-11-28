project_name   = "linuxtips-uncomplicating-eks"
region         = "us-east-1"
use_localstack = true

######## AWS
vpc_id = "vpc-772d8b6afc75e0c67"
public_subnets = [
  "subnet-d8da3a41e697dd513",
  "subnet-00722ace5c56a59a8",
]
private_subnets = [
  "subnet-c42b3e6681e23ce28",
  "subnet-b9e848e0d02c7db76"
]
pod_subnets = [
  "subnet-88fdbd5b88ad1db48",
  "subnet-0675038c2bab82d5b"
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

karpenter_capacity = [
  {
    name               = "linuxtips-uncomplicating-eks-capacity"
    workload           = "linuxtips-uncomplicating-eks-workload"
    ami_family         = "AL2023"
    ami_ssm            = "/aws/service/eks/optimized-ami/1.33/amazon-linux-2023/x86_64/standard/recommended/image_id"
    instance_family    = ["t3", "t3a"]
    instance_sizes     = ["medium", "medium"]
    capacity_type      = ["spot"]
    availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
]
