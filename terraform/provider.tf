provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket       = "ek8-project-terraform-state1"
    key          = "ek8-project/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
