module "vpc" {
  source          = "./modules/vpc"
  cidr_block      = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  enable_nat      = true
}

module "iam" {
  source               = "./modules/iam"
  cluster_name         = var.cluster_name
  github_oidc_audience = var.github_oidc_audience
}

module "ecr" {
  source              = "./modules/ecr"
  frontend_repository = var.frontend_ecr_repository
  backend_repository  = var.backend_ecr_repository
}

module "route53" {
  source                    = "./route53"
  domain_name               = var.domain_name
  subject_alternative_names = ["api.${var.domain_name}"]
}

module "security_groups" {
  source       = "./security-groups"
  vpc_id       = module.vpc.vpc_id
  cluster_cidr = "10.0.0.0/16"
}

module "eks" {
  source                     = "./modules/eks"
  cluster_name               = var.cluster_name
  cluster_role_arn           = module.iam.eks_cluster_role_arn
  node_role_arn              = module.iam.eks_node_role_arn
  cluster_security_group_ids = [module.security_groups.eks_control_plane_security_group_id]
  private_subnets            = module.vpc.private_subnets
  kubernetes_version         = var.kubernetes_version
}

module "rds" {
  source           = "./modules/rds"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnets
  db_username      = var.db_username
  db_password      = var.db_password
  db_name          = var.db_name
  db_instance_type = var.db_instance_type
  public_access    = false
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "ecr_frontend_repository_url" {
  value = module.ecr.frontend_repository_url
}

output "ecr_backend_repository_url" {
  value = module.ecr.backend_repository_url
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}
