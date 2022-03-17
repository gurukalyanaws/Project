variable "aws_region" {}
variable "my_profile" {}
variable "vpc-cidr" {}
variable "subnet_cidr" {}
variable "availablity_zones" {}
variable "ingress_cidr" {}
variable "instance_count" {}
variable "key_name" {}
variable "env" {
  description = "Type of the environment"
  default = "prod"
}
variable "inst_type" {}