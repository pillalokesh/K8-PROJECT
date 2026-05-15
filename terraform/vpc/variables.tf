variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "enable_nat" {
  description = "Enable NAT gateway for private subnets"
  type        = bool
  default     = true
}

variable "azs" {
  description = "Availability zones list"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}
