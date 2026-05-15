#!/bin/bash
set -e

echo "=== Enterprise DevSecOps Deployment Script ==="

# Variables
TERRAFORM_DIR="./terraform"
REGION="ap-south-1"
CLUSTER_NAME="enterprise-eks-cluster"

# Step 1: Initialize Terraform
echo "Step 1: Initializing Terraform..."
cd $TERRAFORM_DIR
terraform init

# Step 2: Validate Terraform configuration
echo "Step 2: Validating Terraform configuration..."
terraform validate

# Step 3: Plan Terraform deployment
echo "Step 3: Planning infrastructure changes..."
terraform plan -out=tfplan

# Step 4: Apply Terraform configuration
echo "Step 4: Applying infrastructure..."
terraform apply tfplan

# Step 5: Get EKS cluster credentials
echo "Step 5: Configuring kubectl..."
aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME

# Step 6: Deploy application to EKS
echo "Step 6: Deploying application to EKS..."
kubectl create namespace enterprise || true
kubectl apply -f ../kubernetes/01-namespace-and-secrets.yaml
kubectl apply -f ../kubernetes/02-backend-deployment.yaml

# Step 7: Deploy with Helm
echo "Step 7: Deploying backend with Helm..."
helm repo add stable https://charts.helm.sh/stable
helm install backend ../helm/backend-chart -n enterprise

# Step 8: Verify deployment
echo "Step 8: Verifying deployment..."
kubectl get pods -n enterprise
kubectl get svc -n enterprise

echo "=== Deployment Complete ==="
