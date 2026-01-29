terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.17.0"
    }
  }
}
# core infrastructure conceptual  VPC   CREATES A PRIVATE AWS NETWORK
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
}
#Subnets
resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block =
var.public_subnets[count.index]
}

# public subnets :- ALB , NAT

resource "aws_subnet" "private" {
  count = 2
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block =
  var.private_subnets[count.index]
}
# private subnets :- EKS nodes & Pods




#eks cluster (control plane )

resource "aws_eks_cluster" "eks" {
  name     = "devops-eks"
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = aws_subnet.private[*].id
  }
}

# kubernetes control plane managed by aws

# worker nodes live in private subnets

#Worker Nodes (Node Group)

resource "aws_eks_node_group" "nodes" {
  cluster_name  = aws_eks_cluster.eks.name
  node_role_arn = aws_iam_role.node_role.arn
  subnet_ids = aws_subnet.private[*].id

   scaling_config {
     desired_size = 2
     max_size     = 3
     min_size     = 1
   }
}
