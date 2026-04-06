output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}

output "security_group_id" {
  value = module.sg.sg_id
}

output "instance_id" {
  value = module.server.instance_id
}

output "public_ip" {
  value = module.server.public_ip
}