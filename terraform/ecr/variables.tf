variable "frontend_repository" {
  description = "Frontend ECR repository name"
  type        = string
  default     = "frontend-ecr-repo"
}

variable "backend_repository" {
  description = "Backend ECR repository name"
  type        = string
  default     = "backend-ecr-repo"
}
