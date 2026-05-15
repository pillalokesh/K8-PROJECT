output "eks_cluster_role_arn" {
  value = module.iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  value = module.iam.eks_node_role_arn
}

output "github_oidc_role_arn" {
  value = module.iam.github_oidc_role_arn
}
