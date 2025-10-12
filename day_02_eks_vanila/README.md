# LinuxTips Uncomplicating EKS Day 02 - Elastic Kubernetes Service - Vanilla Cluster Setup and Wildcard Components (Minimal Setup)

In this second class, we will be creating our first EKS cluster in the simplest and most direct version possible, ideal for those who want a productive environment with efficiency and speed. You will learn concepts about IAM Roles for cluster and nodes, resource encryption with KMS. Together, we will create an EKS Control Plane, explore the advanced concept of EKS Zone Shifter, and address internal authentication with aws-auth and IAM Access Entries. In practice, we will create our first Managed Node Groups and learn about the main managed addons like CoreDNS, kube-proxy and VPC-CNI. Additionally, you will learn how to automate installations with Helm using Terraform through helm_release, performing the first deployment of the lab and starting your productive journey in Kubernetes. The instructor live us the terraform made during the classes in [this link](https://github.com/msfidelis/linuxtips-curso-containers-aws-eks-vanilla)

The resources that was created was:
  - **IAM Roles and KMS**
    - To manager kubectl Auth, Node Auth and so on
  - **Control Planer**
  - **Security to nodes join the cluster**

    - This was configured first using CONFIG_MAP, which was created a config map with the Rule ARN directly, and after was configured using API, which was created the eks access entry

  - **Zone Shifter**

    - Providing a way to AWS automatically manage the nodes when some stability occurs in teh AZ
  
  - **Terraform K8S Provider**
  - **Managed Node Groups**
  - **AWS Addons**

    - CoreDNS, Kube-proxy and VPC-CNI

  - **Terraform Helm Provider**
  - **Metrics server using Helm**
  - **Kube State Metrics using Helm**
  - **First Deploy**