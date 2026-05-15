variable "vpc_id" {
  description = "VPC ID to attach security groups to"
  type        = string
}

variable "cluster_cidr" {
  description = "CIDR block for EKS cluster internal traffic"
  type        = string
  default     = "10.0.0.0/16"
}
