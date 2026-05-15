#!/bin/bash
set -e

echo "=== Terraform Validation and Formatting ==="

TERRAFORM_DIR="./terraform"
cd $TERRAFORM_DIR

# Format all Terraform files
echo "Formatting Terraform files..."
terraform fmt -recursive .

# Validate root configuration
echo "Validating root configuration..."
terraform validate

# Validate each module
for module in modules/vpc modules/ecr modules/eks modules/iam modules/rds; do
  echo "Validating $module..."
  (cd $module && terraform init -backend=false && terraform validate)
done

# Check for security issues
echo "Running terraform security checks..."
if command -v tfsec &> /dev/null; then
  tfsec .
else
  echo "tfsec not installed. Install with: brew install aquasecurity/tfsec/tfsec"
fi

echo "=== Validation Complete ==="
