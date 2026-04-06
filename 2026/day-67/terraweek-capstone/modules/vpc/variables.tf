#cidr range for vpc
variable "vpc_cidr" {
  type = string
}

#cidr range for subnet
variable "public_subnet_cidr" {
  type = string
}

#tags
variable "tags" {
  type = map(string)
  default = {
  }
}

#vpc name
variable "vpc_name" {
  type = string
}

#subnet name
variable "subnet_name" {
  type = string
}

#internet gateway name
variable "gw" {
  type = string
}

#sroute table name
variable "rt" {
  type = string
}