output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "eks_cluster_ca_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}

output "route53_zone_id" {
  value = module.route53.route53_zone_id
}

output "route53_zone_name" {
  value = module.route53.route53_zone_name
}

output "acm_certificate_arn" {
  value = module.route53.acm_certificate_arn
}

output "alb_security_group_id" {
  value = module.security_groups.alb_security_group_id
}

output "eks_nodes_security_group_id" {
  value = module.security_groups.eks_nodes_security_group_id
}

output "rds_security_group_id" {
  value = module.security_groups.rds_security_group_id
}
