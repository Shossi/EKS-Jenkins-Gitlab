
---

# Jenkins-GitLab CI/CD Pipeline Project

![Architecture Diagram](./architecture.jpeg)

## Overview

This project automates the deployment of a cloud infrastructure using Terraform, with continuous integration and deployment pipelines managed by Jenkins and GitLab. The main components include:

- Jenkins (Server-Agent)
- GitLab Server
- EKS (Elastic Kubernetes Service)
- Terraform
- Slack for notifications

For detailed information about the infrastructure setup and Terraform modules, please refer to the [Terraform Documentation](./devops/terraform/README.md).

## Table of Contents

1. [Infrastructure Overview](#infrastructure-overview)
2. [Terraform Components](#terraform-components)
    - [VPC and Subnets](#vpc-and-subnets)
    - [Security Groups](#security-groups)
    - [Instances](#instances)
    - [Load Balancer](#load-balancer)
    - [EKS Cluster](#eks-cluster)
3. [Pipelines](#pipelines)
    - [Branches Pipeline](#branches-pipeline)
    - [Master Pipeline](#master-pipeline)
4. [Application](#application)
5. [Tests](#tests)
6. [Monitoring](#aws-cloudwatch-monitoring)
7. [Configurations](#configurations)
    - [Jenkins](#jenkins)
    - [GitLab](#gitlab)

---

## Infrastructure Overview

The infrastructure is entirely managed by Terraform and includes two VPCs—one for Jenkins, GitLab, and the bastion host, and the other for the EKS cluster and its associated components. For more details, please see the [Terraform Documentation](./devops/terraform/README.md).

## Terraform Components

### VPCs and Subnets

- **VPC 1**: Dedicated for Jenkins, GitLab, and the bastion host with **1 private subnet and 1 public subnet**.
- **VPC 2**: Dedicated for the EKS cluster with **2 private subnets and 2 public subnets** for secure networking.

### Security Groups

- **VPC 1**: Security Groups for Jenkins, GitLab, and the bastion host.
- **VPC 2**: Security Groups for the EKS cluster and its associated components.

### Instances (VPC 1)

- `Jenkins Agent`: Deployed in the private subnet.
- `Jenkins Controller`: Deployed in the private subnet.
- `GitLab`: Deployed in the private subnet.
- `Bastion Host`: Deployed in the public subnet for secure SSH access.

### Load Balancer (VPC 1)

- Application Load Balancer with listeners for Jenkins and GitLab.
  - `Jenkins`: port 8080
  - `GitLab`: port 80

### EKS Cluster (VPC 2)

- The EKS cluster is deployed in VPC 2 with nodes in private subnets and necessary IAM roles provisioned through Terraform.
- The cluster is configured with the following key add-ons and Helm charts:

#### Add-ons Deployed via Terraform:
- **CoreDNS**: Enables service discovery within the cluster.
- **VPC CNI**: Integrates Kubernetes networking with AWS VPC for efficient pod networking.
- **Kube-Proxy**: Manages networking rules and service communication across nodes.
- **CloudWatch Agent**: Collects and pushes logs and metrics from the cluster to AWS CloudWatch for monitoring.

#### Helm Charts Deployed:
- **Cluster Autoscaler**: Automatically adjusts the number of nodes in the cluster based on CPU and memory usage.
- **AWS Load Balancer Controller**: Manages AWS Application Load Balancers for services exposed via Kubernetes.
- **ArgoCD**: GitOps continuous deployment tool that automatically deploys application updates when changes are made to the GitHub repository.

---

## Pipelines

![Pipeline Diagram](./pipeline.jpeg)

### Branches Pipeline

- Stages:
    - Build Docker Image
    - Test Docker Image

- `Trigger`: Merge Request to Master branch.

### Master Pipeline

- Stages:
    - Determines the source branch of the merge request.
    - Updates the version depending on the source branch (Major for `release/*`, Minor for `feature/*`, Patch for `hotfix/*`).
    - Builds the artifact (Docker image).
    - Pushes the Docker image to Docker Hub ([yossizxc/weather](https://hub.docker.com/repository/docker/yossizxc/weather/general)).
    - Updates the values.yaml file in the GitHub repository with the new image tag.
    - ArgoCD detects the change in the GitHub repository and automatically redeploys the updated application on the Kubernetes cluster.

- `Trigger`: Accepted Merge Request to Master Branch.

---

## Application

- **Weather API:**
    - A Flask application using Gunicorn as a WSGI server.

---

## Tests

- **Connectivity Test:**
    - Checks if the server is running properly by sending a request to the localhost on the specified port.

- **Code Linting:**
    - A pre-push Git hook runs pylint to ensure code quality before code is pushed to the repository.

---

## AWS CloudWatch Monitoring

This project uses AWS CloudWatch to monitor the infrastructure:

- **EC2 Instance Monitoring:**
    - Collects metrics such as CPU utilization, disk usage, and memory usage.
    - Configured using the AWS CloudWatch Agent.

- **EKS Monitoring:**
    - The **Cloud Observability Agent** is deployed to collect and send logs and metrics from the EKS cluster to CloudWatch.
  
- **CloudWatch Alarms:**
    - Alarms set up to notify when thresholds (e.g., high CPU usage) are breached.
    - Notifications sent via SNS to your email.

---

## Configurations

### Jenkins

- **Credentials:**
    - GitLab account for SCM connection.
    - AWS Credentials.
    - DockerHub Credentials.
    - SSH key or other configurations for agent-controller connection.
    - Slack Credentials.

- **Pipelines:**
    - Create two pipelines with the relevant configurations:
        - One for created and updated merge requests.
        - One for accepted merge requests (includes additional parameters).

- **Shared Groovy Library:**
    - Used to implement and maintain the versioning scheme and configuration.

### GitLab

- **Webhooks:**
    - One webhook for the branch pipeline (builds and tests).
    - Another webhook for the deployment pipeline (triggered upon merge request acceptance).

---
