project_name = "uncomplicating-eks"
region       = "us-east-1"

######## AWS
vpc_id = "vpc-03b22061d7648182a"
public_subnets = [
  "subnet-07b28e126f5e958da",
  "subnet-06035a570ea949c58",
]
private_subnets = [
  "subnet-0cd10a3a924e77ace",
  "subnet-030e5f523322c8b9f"
]
pod_subnets = [
  "subnet-06035a570ea949c58",
  "subnet-07b28e126f5e958da"
]
addon_cni_version            = "v1.20.4-eksbuild.1"
addon_coredns_version        = "v1.12.4-eksbuild.1"
addon_kubeproxy_version      = "v1.33.3-eksbuild.10"
addon_pod_identity_version   = "v1.3.9-eksbuild.3"
addon_efs_csi_driver_version = "v2.1.9-eksbuild.1"

auto_scale_options = {
  min     = 2
  max     = 2
  desired = 2
}

nodes_instance_sizes = [
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
