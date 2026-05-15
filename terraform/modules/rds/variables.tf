variable "vpc_id" {
  description = "VPC ID where RDS is deployed"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for RDS"
  type        = list(string)
}

variable "db_username" {
  description = "RDS master username"
  type        = string
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "RDS database name"
  type        = string
}

variable "db_instance_type" {
  description = "RDS instance class"
  type        = string
}

variable "public_access" {
  description = "Whether RDS should be publicly accessible"
  type        = bool
}
