module "eks" {
  source             = "../modules/eks"
  cluster_name       = var.cluster_name
  cluster_role_arn   = var.cluster_role_arn
  node_role_arn      = var.node_role_arn
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  vpc_id             = var.vpc_id
  kubernetes_version = var.kubernetes_version
}
