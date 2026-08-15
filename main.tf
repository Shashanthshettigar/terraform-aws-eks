module "vpc" {

  source = "./modules/vpc"

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"

  az1 = "us-east-1a"
  az2 = "us-east-1b"

}



module "iam" {

  source = "./modules/iam"

}



module "eks" {

  source = "./modules/eks"

  cluster_name     = "demo-eks"
  cluster_role_arn = module.iam.cluster_role_arn

  subnet_ids = [
    module.vpc.public_subnet_1_id,
    module.vpc.public_subnet_2_id
  ]

}



module "nodegroup" {

  source = "./modules/nodegroup"

  cluster_name  = module.eks.cluster_name
  node_role_arn = module.iam.node_role_arn

  subnet_ids = [
    module.vpc.public_subnet_1_id,
    module.vpc.public_subnet_2_id
  ]

  instance_types = ["t3.small"]

  desired_size = 2
  min_size     = 1
  max_size     = 3

}
