# 🧠 Amazon EKS Cluster Setup Guide

This guide provides detailed instructions to create and manage an **Amazon EKS (Elastic Kubernetes Service)** cluster and its associated node group using AWS services. By the end, you'll have a fully functioning Kubernetes cluster running on AWS.

---

## 🚀 Step-by-Step Guide

### 1. Log in with an IAM User with Required Permissions

Ensure you're logged into the AWS Console using an **IAM user** that has sufficient permissions to create and manage EKS resources.

The IAM user **must have permissions** for the following services:

| Service                    | Required Permissions                                                                         |
| -------------------------- | -------------------------------------------------------------------------------------------- |
| **EKS**                    | `eks:*` or specific actions like `CreateCluster`, `DescribeCluster`, `CreateNodegroup`, etc. |
| **EC2**                    | VPC, subnets, security groups: `ec2:*` or scoped actions                                     |
| **IAM**                    | `iam:PassRole`, `iam:GetRole`, `iam:CreateRole`, `iam:AttachRolePolicy`                      |
| **CloudFormation**         | To provision infrastructure via templates: `cloudformation:*`                                |
| **Auto Scaling**           | To manage node groups: `autoscaling:*`                                                       |
| **CloudWatch**             | For monitoring and logging: `logs:*`, `cloudwatch:*`                                         |
| **Elastic Load Balancing** | For managing load balancers: `elasticloadbalancing:*`                                        |

> ✅ **Tip:** You can use the AWS-managed IAM policies like:
>
> - `AmazonEKSClusterPolicy`
> - `AmazonEKSWorkerNodePolicy`
> - `AmazonEKSServicePolicy`
> - `AmazonVPCFullAccess`
> - `IAMFullAccess` (or scoped custom policies)
> - `CloudWatchFullAccess`
> - `AmazonEKS_CNI_Policy`

---

### 2. Follow the video tutorial to proceed with cluster and node group creation.

👉 **[Watch the EKS Cluster Setup Video](#)**

---

### 3. Open AWS CloudShell

> Go to the AWS Console and launch **CloudShell** from the top-right menu.

---

### 4. Use below command to connect Cluster using aws CloudShell

```bash
aws eks update-kubeconfig --region <region name. eg: ap-south-1> --name <cluster name>
```
