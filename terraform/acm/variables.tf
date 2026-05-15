variable "domain_name" {
  description = "ACM certificate domain name"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional certificate subject alternative names"
  type        = list(string)
  default     = []
}
