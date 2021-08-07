
module "vpc_plus" {
  source = "../modules/vpc"
  aws_region = var.aws_region
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  environment = var.environment
  aws-profile = var.aws-profile
  vpc_cidr = var.vpc_cidr
}
module "Bastion" {
  source = "../modules/instance"
  numberofservers = "1"
  aws_region = var.aws_region
  ami_id = var.ami_id
  key_name = var.key_name
  subnet_id = module.vpc_plus.public_subnet1
  vpc_cidr = var.vpc_cidr
  msk_vpc = module.vpc_plus.msk_vpc_id
  security_group_id = module.vpc_plus.Bastion_SG_id
}

module "myasg" {
  source = "../modules/asg"
  ami_id = var.ami_id
  public_subnet1 = module.vpc_plus.public_subnet1
  security_groups = module.vpc_plus.security_groups
  aws_region = var.aws_region
  key_name = var.key_name
   }
