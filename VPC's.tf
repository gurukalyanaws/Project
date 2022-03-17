resource "aws_vpc" "VPC" {
  cidr_block = "${var.vpc-cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
     "Name" = "terraform_VPC"
    }
}

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.VPC.id
  count = "${length(var.subnet_cidr)}"
  availability_zone = "${element(var.availablity_zones, count.index) }"
  cidr_block = "${element(var.subnet_cidr, count.index) }"
  tags = {
     "Name" = "terraform_subnet-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    "Name" = "terraform_IGW"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  } 
  tags = {
    "Name" = "terraform_RT"
  }
}

resource "aws_route_table_association" "RT_association" {
  count = "${length(var.subnet_cidr)}"
  subnet_id = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = aws_route_table.RT.id
}