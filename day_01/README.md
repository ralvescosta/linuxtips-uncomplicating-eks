# LinuxTips Uncomplicating EKS Day 01

In day 01 was created a AWS network configuration to accommodate our cluster, we did this using terraform.
The instructor live us the terraform made during the classes in [this link](https://github.com/msfidelis/linuxtips-curso-containers-aws-eks-networking), the network struct follows the image bellow

![AWS EKS Networking](../.imgs/aws-eks-networking.png)

## Commands

> terraform init

> terraform apply --auto-approve -var-file=terraform.tfvars