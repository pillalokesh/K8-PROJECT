cluster_name               = "enterprise-eks-cluster"
cluster_role_arn           = "arn:aws:iam::ACCOUNT_ID:role/enterprise-eks-cluster-role"
node_role_arn              = "arn:aws:iam::ACCOUNT_ID:role/enterprise-eks-nodegroup-role"
public_subnets             = ["subnet-00000000000000000", "subnet-00000000000000001"]
private_subnets            = ["subnet-00000000000000002", "subnet-00000000000000003"]
vpc_id                     = "vpc-00000000000000000"
kubernetes_version         = "1.29"
