variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "enable_nat" {
  description = "Enable NAT gateway for private subnets"
  type        = bool
  default     = true
}

variable "azs" {
  description = "Availability zones list"
  type        = list(string)
}
