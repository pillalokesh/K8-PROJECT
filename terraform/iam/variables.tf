variable "cluster_name" {
  description = "Name of the EKS cluster for IAM role naming"
  type        = string
  default     = "enterprise-eks-cluster"
}

variable "github_oidc_audience" {
  description = "GitHub Actions OIDC audience"
  type        = string
  default     = "sts.amazonaws.com"
}
