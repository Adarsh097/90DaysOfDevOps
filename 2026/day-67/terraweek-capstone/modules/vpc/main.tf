resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

data "aws_availability_zones" "az" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.az.names[0]
  tags = merge(var.tags, {
    Name = var.subnet_name
  })
}

#Internet Gateway - connects VPC to public internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(var.tags, {
    Name = var.gw
  })
}

#Route table - route traffic from subnet to internet gateway
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = merge(var.tags, {
    Name = var.rt
  })
}

#Link route table to subnet
resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}