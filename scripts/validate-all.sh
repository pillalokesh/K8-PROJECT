#!/bin/bash

# Enterprise DevSecOps Validation Script
# This script validates all components of the infrastructure

set -e

echo "=========================================="
echo "Enterprise DevSecOps - Validation Script"
echo "=========================================="

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track results
PASSED=0
FAILED=0

# Function to print results
print_result() {
  if [ $1 -eq 0 ]; then
    echo -e "${GREEN}✓ PASSED${NC}: $2"
    ((PASSED++))
  else
    echo -e "${RED}✗ FAILED${NC}: $2"
    ((FAILED++))
  fi
}

# Check Docker
echo -e "\n${YELLOW}Checking Docker...${NC}"
if command -v docker &> /dev/null; then
  docker --version
  print_result 0 "Docker is installed"
else
  print_result 1 "Docker is not installed"
fi

# Check Docker Compose
echo -e "\n${YELLOW}Checking Docker Compose...${NC}"
if command -v docker-compose &> /dev/null; then
  docker-compose --version
  print_result 0 "Docker Compose is installed"
else
  print_result 1 "Docker Compose is not installed"
fi

# Check Terraform
echo -e "\n${YELLOW}Checking Terraform...${NC}"
if command -v terraform &> /dev/null; then
  TERRAFORM_VERSION=$(terraform version | head -n 1)
  echo "$TERRAFORM_VERSION"
  print_result 0 "Terraform is installed"
else
  print_result 1 "Terraform is not installed"
fi

# Check AWS CLI
echo -e "\n${YELLOW}Checking AWS CLI...${NC}"
if command -v aws &> /dev/null; then
  aws --version
  if aws sts get-caller-identity &> /dev/null; then
    print_result 0 "AWS CLI is configured"
  else
    print_result 1 "AWS CLI is not configured"
  fi
else
  print_result 1 "AWS CLI is not installed"
fi

# Check kubectl
echo -e "\n${YELLOW}Checking kubectl...${NC}"
if command -v kubectl &> /dev/null; then
  kubectl version --client
  print_result 0 "kubectl is installed"
else
  print_result 1 "kubectl is not installed"
fi

# Check Helm
echo -e "\n${YELLOW}Checking Helm...${NC}"
if command -v helm &> /dev/null; then
  helm version
  print_result 0 "Helm is installed"
else
  print_result 1 "Helm is not installed"
fi

# Validate Terraform files
echo -e "\n${YELLOW}Validating Terraform files...${NC}"
cd terraform
if terraform validate > /dev/null 2>&1; then
  print_result 0 "Terraform files are valid"
else
  print_result 1 "Terraform validation failed"
fi

# Check Dockerfile syntax
echo -e "\n${YELLOW}Checking Dockerfiles...${NC}"
for dockerfile in apps/*/Dockerfile; do
  if [ -f "$dockerfile" ]; then
    echo "Checking $dockerfile..."
    # Basic Docker syntax check
    if grep -q "FROM" "$dockerfile"; then
      print_result 0 "$dockerfile exists"
    else
      print_result 1 "$dockerfile is invalid"
    fi
  fi
done

# Print summary
echo -e "\n=========================================="
echo -e "Summary:"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo "=========================================="

if [ $FAILED -eq 0 ]; then
  echo -e "${GREEN}All validations passed!${NC}"
  exit 0
else
  echo -e "${RED}Some validations failed. Please fix the issues and try again.${NC}"
  exit 1
fi
