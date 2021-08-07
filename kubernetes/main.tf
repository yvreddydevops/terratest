provider aws {
  region = "eu-west-2"
}

module "kubernetes" {
  source = "../modules/vpc"
  aws-profile = var.aws-profile
  aws_region = var.aws_region
  environment = var.environment
  application = var.application
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

}