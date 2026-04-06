variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "tags" {
  type = map(string)
  default = {
  }
}

variable "instance_name" {
  description = "isntance name"
  type        = string
}
