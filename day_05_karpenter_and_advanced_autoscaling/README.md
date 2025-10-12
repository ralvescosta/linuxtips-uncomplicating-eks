# LinuxTips Uncomplicating EKS Day 05 - Karpenter and Advanced Autoscaling Strategies

In this fifth class, you will learn about Karpenter, a powerful and high-performance tool that takes autoscaling in EKS to another level, replacing the traditional Cluster Autoscaler. Together, we will learn how to implement advanced strategies using EC2NodeClasses and NodePools, understanding how to segregate and distribute workloads with maximum efficiency. You will discover how to direct your applications to specific pools, ensuring the ideal balance between performance and cost. In addition, we will cover essential precautions when using Topology Spreads, maintaining high availability and stability in dynamic environments. Finally, you will learn how to use the Interruption Queue feature, which ensures resilience and stability even in scenarios of extreme volatility, making your Kubernetes infrastructure prepared for any sudden increase in demand. The instructor live us the terraform made during the classes in [this repository](https://github.com/msfidelis/linuxtips-curso-containers-aws-eks-vanilla/tree/aula/karpenter)

The resources that was created was:
  - **Helm Karpenter Installation**
  - **IAM Roles**
  - **EC2 NodeClasses and NodePools**
  - **Spot Nodes**
  - **Multi NodePools and Workloads segregation**
  - **Interruption Queue**