provider "aws" {
  region = var.aws_region
}
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
  ami_id = trimspace(var.ami_id)
 # user_data = base64encode(data.template_file.myfile.rendered)
  key_name = "practicalnetworking"
  subnet_id = module.vpc_plus.public_subnet_ids
  vpc_cidr = var.vpc_cidr
  msk_vpc = module.vpc_plus.msk_vpc_id
  security_group_id = module.vpc_plus.Bastion_SG_id
}

module "mylb" {
  source = "../modules/elb"
  lb_port = 80
  subnets_ex = module.vpc_plus.public_subnet_ids
  vpc_id = module.vpc_plus.msk_vpc_id

}

data "template_file" "myfile" {
   template = "${file("${path.module}/launch_apache.sh")}"

}




module "myasg" {
  source = "../modules/asg"
  ami_id = trimspace(var.ami_id)
  aws_region = "eu-west-2"
  asg_cidr = var.vpc_cidr
  autoscaling_subnets = module.vpc_plus.pravite_subnet_id
  health_check_type = "ELB"
  user_data = base64encode(data.template_file.myfile.rendered)
  autoscale_name = "autoscale"
  min_size = 2
  max_size = 4
  alb_target_grp_arn = module.mylb.lb_tgt_arn
  PATH_TO_PRIVATE_KEY = "practicalnetworking"
  vpc_id = module.vpc_plus.msk_vpc_id

}

resource "aws_security_group_rule" "allow_lb_asg" {
  from_port = 80
  protocol = "tcp"
  security_group_id = module.myasg.asg_sec_id
  source_security_group_id = module.mylb.lb_sec_group
  to_port = 80
  type = "ingress"
}
