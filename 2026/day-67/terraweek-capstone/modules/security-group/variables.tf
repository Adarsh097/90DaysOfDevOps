variable "vpc_id" {
  type = string
}

variable "ingress_ports" {
  type = list(number)
}

variable "sg_name" {
  description = "Security group name"
  type        = string
}

#tags
variable "tags" {
  type = map(string)
  default = {
  }
}
