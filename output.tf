output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1" {
  value = module.vpc.public_subnet_1_id
}

output "public_subnet_2" {
  value = module.vpc.public_subnet_2_id
}




output "cluster_role_arn" {

  value = module.iam.cluster_role_arn

}