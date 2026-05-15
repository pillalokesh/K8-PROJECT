variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-south-1"
}

variable "azs" {
  description = "Availability zones for VPC subnets"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "enterprise-eks-cluster"
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "frontend_ecr_repository" {
  description = "ECR repository name for the frontend application"
  type        = string
  default     = "frontend-ecr-repo"
}

variable "backend_ecr_repository" {
  description = "ECR repository name for the backend application"
  type        = string
  default     = "backend-ecr-repo"
}

variable "db_username" {
  description = "RDS database master username"
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "RDS database master password"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "db_name" {
  description = "RDS database name"
  type        = string
  default     = "appdb"
}

variable "db_instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "domain_name" {
  description = "Primary Route53 domain name"
  type        = string
  default     = "lokeshwaffle.in"
}

variable "github_oidc_audience" {
  description = "GitHub Actions OIDC audience"
  type        = string
  default     = "sts.amazonaws.com"
}
