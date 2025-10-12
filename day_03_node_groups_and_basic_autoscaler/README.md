# LinuxTips Uncomplicating EKS Day 03 - Computing: Node Groups and Cluster Autoscaler Strategies

In the third lesson, we will take a step further in the intelligent management of computing resources in your EKS cluster. You will learn advanced strategies to organize and optimize workloads using Managed Node Groups, exploring the best cost-benefit between Spot and On-Demand nodes, in addition to experimenting with node provisioning with Amazon Linux and Bottlerocket. We will explore the power of x86 and ARM64 (Graviton2) architectures, understanding how to segment specific applications using Node Selectors and Labels, ensuring that each workload runs exactly where it makes the most sense. You will also learn how to distribute applications precisely using Node Affinity and Ant-affinity, ensuring high availability across multiple zones. Finally, we will cover how to customize your nodes using custom Launch Templates, automate cluster scaling with Cluster Autoscaler and manage the safe shutdown of Spot nodes with Node Termination Handler, ensuring stability and savings in your Kubernetes infrastructure. The instructor live us the terraform made during the classes in [this link](https://github.com/msfidelis/linuxtips-curso-containers-aws-eks-vanilla/tree/aula/node_groups)

The resources that was created was:

  - **Managed Node Groups On-Demand e Spots**

  - **Managed Node Groups com Bottlerocket**

  - **Managed Node Groups com Graviton (arm64)**

  - **Segregating Workloads with Multiple Node Groups and Node Selectors**

  - **Segregating Workloads with Multiple Node Groups and Node Affinity**

  - **Segregating Workloads by Criticality Criteria**

  - **Using Custom Launch Templates**

  - **IAM Roles and Helm for Cluster Autoscaler**

  - **SQS, Event Bridge, Node Termination Handler**