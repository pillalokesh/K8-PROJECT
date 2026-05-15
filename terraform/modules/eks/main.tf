data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  version = var.kubernetes_version

  vpc_config {
    subnet_ids              = var.private_subnets
    security_group_ids      = var.cluster_security_group_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
    public_access_cidrs     = var.public_access_cidrs
  }

  lifecycle {
    ignore_changes = [
      version
    ]
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

  disk_size = var.node_group_disk_size
  labels    = var.node_group_labels
  tags = merge({
    Name = "enterprise-node-group"
  }, var.node_group_tags)

  capacity_type = "ON_DEMAND"
}
