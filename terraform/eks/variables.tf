variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "enterprise-eks-cluster"
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS worker nodes"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet IDs for EKS networking"
  type        = list(string)
  default     = ["subnet-00000000000000000", "subnet-00000000000000001"]
}

variable "private_subnets" {
  description = "Private subnet IDs for EKS worker nodes"
  type        = list(string)
  default     = ["subnet-00000000000000002", "subnet-00000000000000003"]
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.29"
}
