# Enterprise DevSecOps Platform

A comprehensive cloud-native infrastructure and application deployment platform built on AWS EKS, Terraform, Docker, and Kubernetes.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [Infrastructure as Code](#infrastructure-as-code)
- [Deployment](#deployment)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)

## Overview

This project provides a complete enterprise-grade infrastructure setup including:

- **AWS EKS Cluster**: Kubernetes orchestration on AWS
- **Amazon RDS**: Managed MySQL database
- **Amazon ECR**: Container registry for Docker images
- **AWS Route53**: DNS management and ACM certificates
- **Terraform**: Infrastructure as Code for AWS resources
- **Helm**: Kubernetes package management
- **Docker**: Containerization for backend and frontend
- **Docker Compose**: Local development environment

## Architecture

### Cloud Infrastructure (AWS)

```
┌─────────────────────────────────────────────────────────┐
│                      AWS Account                         │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  ┌──────────────────────────────────────────────────┐   │
│  │             VPC (10.0.0.0/16)                    │   │
│  │                                                  │   │
│  │  ┌──────────────┐      ┌──────────────┐         │   │
│  │  │  EKS Cluster │      │   RDS MySQL  │         │   │
│  │  │              │      │              │         │   │
│  │  │  ┌────────┐  │      │  8.0 Engine  │         │   │
│  │  │  │ Backend│  │      │              │         │   │
│  │  │  │ Pod    │  │──────│ enterprise   │         │   │
│  │  │  ├────────┤  │      │              │         │   │
│  │  │  │Frontend│  │      └──────────────┘         │   │
│  │  │  │Nginx   │  │                               │   │
│  │  │  └────────┘  │                               │   │
│  │  └──────────────┘                               │   │
│  │                                                  │   │
│  └──────────────────────────────────────────────────┘   │
│                                                           │
│  ┌────────────┐  ┌──────────────┐  ┌──────────────┐   │
│  │   ECR      │  │  Route53     │  │     ACM      │   │
│  │ Registries │  │  DNS Zone    │  │ Certificates │   │
│  └────────────┘  └──────────────┘  └──────────────┘   │
│                                                           │
└─────────────────────────────────────────────────────────┘
```

### Application Stack

```
Frontend (React) → Nginx → Backend API (Node.js/Express) → MySQL (RDS)
```

## Prerequisites

### Required Tools

- AWS CLI v2
- Terraform >= 1.4.0
- kubectl >= 1.25
- Helm 3
- Docker & Docker Compose
- Git
- Node.js 18+ (for local development)

### AWS Requirements

- AWS Account with appropriate IAM permissions
- AWS Region: ap-south-1
- Domain registered in Route53

### Install Prerequisites

```bash
# macOS
brew install awscli2 terraform kubectl helm docker

# Ubuntu/Debian
sudo apt-get install awscli terraform kubectl helm docker.io

# Windows (using Chocolatey)
choco install awscli terraform kubectl helm docker
```

## Project Structure

```
EK8-PROJECT/
├── terraform/                    # Infrastructure as Code
│   ├── main.tf                  # Root configuration
│   ├── variables.tf             # Variables
│   ├── outputs.tf               # Outputs
│   ├── provider.tf              # AWS provider config
│   ├── versions.tf              # Provider versions
│   ├── terraform.tfvars         # Variable values
│   ├── modules/                 # Reusable modules
│   │   ├── vpc/                 # VPC module
│   │   ├── eks/                 # EKS cluster module
│   │   ├── ecr/                 # ECR registry module
│   │   ├── iam/                 # IAM roles module
│   │   └── rds/                 # RDS database module
│   ├── vpc/                     # VPC wrapper configuration
│   ├── eks/                     # EKS wrapper configuration
│   ├── ecr/                     # ECR wrapper configuration
│   ├── iam/                     # IAM wrapper configuration
│   ├── acm/                     # ACM certificates
│   ├── route53/                 # DNS & certificates
│   └── security-groups/         # Security groups
├── apps/                        # Applications
│   ├── backend/                 # Node.js/Express backend
│   │   ├── src/
│   │   │   └── index.js        # Main server file
│   │   ├── Dockerfile
│   │   └── package.json
│   └── frontend/                # React frontend
│       ├── src/
│       │   ├── App.js
│       │   └── index.js
│       ├── Dockerfile
│       ├── nginx.conf
│       └── package.json
├── helm/                        # Helm charts
│   └── backend-chart/           # Backend Helm chart
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
├── kubernetes/                  # Kubernetes manifests
│   ├── 01-namespace-and-secrets.yaml
│   ├── 02-backend-deployment.yaml
│   └── 03-network-policies.yaml
├── monitoring/                  # Monitoring configuration
│   └── prometheus-config.yaml
├── scripts/                     # Automation scripts
│   ├── deploy.sh
│   └── validate.sh
├── docker-compose.yml           # Local development
└── README.md                    # This file
```

## Quick Start

### 1. Local Development with Docker Compose

```bash
# Start all services locally
docker-compose up -d

# Check services
docker-compose ps

# Access applications
# Frontend: http://localhost:80
# Backend: http://localhost:4000
# MySQL: localhost:3306

# Stop services
docker-compose down
```

### 2. Deploy to AWS EKS

#### Step 1: Configure AWS Credentials

```bash
aws configure
# Enter:
# AWS Access Key ID: [YOUR_ACCESS_KEY]
# AWS Secret Access Key: [YOUR_SECRET_KEY]
# Default region: ap-south-1
# Default output: json
```

#### Step 2: Initialize Terraform

```bash
cd terraform
terraform init
```

#### Step 3: Review Plan

```bash
terraform plan
```

#### Step 4: Apply Infrastructure

```bash
terraform apply
# Review and type 'yes' to confirm
```

#### Step 5: Configure kubectl

```bash
aws eks update-kubeconfig --region ap-south-1 --name enterprise-eks-cluster
```

#### Step 6: Deploy Application

```bash
# Deploy using kubectl
kubectl apply -f ../kubernetes/01-namespace-and-secrets.yaml
kubectl apply -f ../kubernetes/02-backend-deployment.yaml

# Or deploy using Helm
helm install backend ./helm/backend-chart -n enterprise
```

## Infrastructure as Code

### Terraform Modules

#### VPC Module
- Creates VPC with public and private subnets
- Configures Internet Gateway and NAT Gateway
- Sets up route tables for public and private subnets

#### EKS Module
- Creates managed Kubernetes cluster
- Configures node groups with auto-scaling
- Sets up cluster security and networking

#### RDS Module
- Creates MySQL 8.0 database instance
- Configures subnet groups and security
- Sets up automated backups and encryption

#### IAM Module
- Creates roles for EKS cluster and nodes
- Sets up GitHub Actions OIDC provider
- Configures necessary policies

#### ECR Module
- Creates repositories for frontend and backend
- Enables image scanning and encryption

### GitHub Actions CI/CD Integration
- The repository includes `.github/workflows/ci-cd.yml` for building, testing, and publishing images to ECR.
- It uses GitHub Actions OIDC to assume an AWS role via `AWS_ROLE_TO_ASSUME`.
- Configure this secret in GitHub with the ARN of the IAM role trusted by GitHub Actions.
- ArgoCD will then deploy the updated image tags from `argocd/backend-app.yaml`.

### Variables Configuration

Edit `terraform/terraform.tfvars`:

```hcl
aws_region             = "ap-south-1"
azs                    = ["ap-south-1a", "ap-south-1b"]
vpc_cidr               = "10.0.0.0/16"
cluster_name           = "enterprise-eks-cluster"
kubernetes_version     = "1.29"
domain_name            = "your-domain.com"
db_username            = "adminuser"
db_password            = "SecurePassword123!"
```

## Deployment

### Build and Push Docker Images

```bash
# Build images
docker build -t frontend-app:latest ./apps/frontend
docker build -t backend-app:latest ./apps/backend

# Push to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com

docker tag backend-app:latest ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/backend-ecr-repo:latest
docker push ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/backend-ecr-repo:latest
```

### Deploy with Helm

```bash
# Add Helm repositories
helm repo add stable https://charts.helm.sh/stable

# Deploy backend
helm install backend ./helm/backend-chart -n enterprise -f helm/backend-chart/values.yaml

# Update deployment
helm upgrade backend ./helm/backend-chart -n enterprise

# Uninstall
helm uninstall backend -n enterprise
```

## Configuration

### Environment Variables

#### Backend (.env)
```
NODE_ENV=production
PORT=4000
DB_HOST=enterprise-rds-db.xxx.ap-south-1.rds.amazonaws.com
DB_USER=adminuser
DB_PASSWORD=SecurePassword123!
DB_NAME=appdb
```

#### Frontend (.env)
```
REACT_APP_API_URL=https://api.your-domain.com
```

### Kubernetes Secrets

Secrets are stored in Kubernetes and managed by terraform and kubectl:

```bash
kubectl get secrets -n enterprise
kubectl describe secret db-secret -n enterprise
```

## Monitoring and Logging

### Prometheus
Configuration available in `monitoring/prometheus-config.yaml`

### Application Health Checks
- Backend: `http://localhost:4000/api/health`
- Frontend: `http://localhost:80`

## Troubleshooting

### EKS Cluster Issues

```bash
# Check cluster status
aws eks describe-cluster --name enterprise-eks-cluster

# Get cluster logs
aws eks describe-cluster --name enterprise-eks-cluster --query 'cluster.logging'

# View node groups
aws eks list-nodegroups --cluster-name enterprise-eks-cluster
```

### Kubernetes Debugging

```bash
# Check pods
kubectl get pods -n enterprise

# View pod logs
kubectl logs <pod-name> -n enterprise

# Describe pod (for events)
kubectl describe pod <pod-name> -n enterprise

# Access pod shell
kubectl exec -it <pod-name> -n enterprise -- /bin/sh
```

### Database Connection Issues

```bash
# Test RDS connection
mysql -h <rds-endpoint> -u adminuser -p

# Check security groups
aws ec2 describe-security-groups --filters Name=group-name,Values=enterprise-rds-sg
```

### Terraform State Issues

```bash
# View state
terraform state list

# Refresh state
terraform refresh

# Backup state
cp terraform.tfstate terraform.tfstate.backup
```

## Security Best Practices

1. **Secrets Management**: Use AWS Secrets Manager or Kubernetes Secrets
2. **Network Security**: Implement network policies and security groups
3. **RBAC**: Use Kubernetes RBAC for access control
4. **TLS/SSL**: Enable TLS for all communications
5. **Image Scanning**: Enable ECR image scanning
6. **Backup**: Regular backups of RDS database

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes and test
4. Submit a pull request

## License

This project is licensed under the MIT License - see LICENSE file for details.

## Support

For issues and questions:
- Create an issue in the repository
- Contact: devops@lokeshwaffle.in

## References

- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Helm Documentation](https://helm.sh/docs/)

---

**Last Updated**: May 15, 2026
**Version**: 1.0.0
