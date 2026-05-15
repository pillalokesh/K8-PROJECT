module "iam" {
  source               = "../modules/iam"
  cluster_name         = var.cluster_name
  github_oidc_audience = var.github_oidc_audience
}
