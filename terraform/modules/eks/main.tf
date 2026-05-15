data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  version = var.kubernetes_version

  vpc_config {
    subnet_ids              = var.private_subnets
    endpoint_public_access  = true
    endpoint_private_access = false
    public_access_cidrs     = ["0.0.0.0/0"]
  }
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "enterprise-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  capacity_type = "ON_DEMAND"
}
