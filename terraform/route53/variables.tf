variable "domain_name" {
  description = "Primary Route53 domain name"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional domains to cover in the ACM certificate"
  type        = list(string)
  default     = []
}
