data "aws_ami" "ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.subnet_cidr
  tags               = local.common_tags
  subnet_name        = "${local.name_prefix}-SUBNET"
  vpc_name           = "${local.name_prefix}-VPC"
  gw                 = "${local.name_prefix}-GW"
  rt                 = "${local.name_prefix}-RT"
}

module "sg" {
  source        = "./modules/security-group"
  vpc_id        = module.vpc.vpc_id
  sg_name       = "${local.name_prefix}-SG"
  tags          = local.common_tags
  ingress_ports = var.ingress_ports
}

module "server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.ami.id
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.sg.sg_id]
  instance_name      = "${local.name_prefix}-SERVER"
  tags               = local.common_tags
  instance_type      = var.instance_type
}