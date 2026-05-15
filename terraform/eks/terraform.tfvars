cluster_name = "enterprise-eks-cluster"

cluster_role_arn = "arn:aws:iam::385168913795:role/enterprise-eks-cluster-role"

node_role_arn = "arn:aws:iam::385168913795:role/enterprise-eks-nodegroup-role"

private_subnets = [
  "subnet-04e7c963b7f2e1f64",
  "subnet-0ef358991ac98d842",
  "subnet-0caa6bb096ffd99ca",
  "subnet-01c078c5f500620ec"
]

kubernetes_version = "1.30"