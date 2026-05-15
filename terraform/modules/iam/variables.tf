variable "cluster_name" {
  description = "EKS cluster name for IAM role naming"
  type        = string
}

variable "github_oidc_audience" {
  description = "GitHub Actions OIDC audience value"
  type        = string
}
