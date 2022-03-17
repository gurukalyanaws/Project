variable "aws_region" {}
variable "my_profile" {}
variable "vpc-cidr" {}
variable "subnet_cidr" {}
variable "availablity_zones" {}
variable "ingress_cidr" {}
variable "instance_count" {
  type = map (number)
    default = {
    "master" = 1
    "slave" = 2
    }
}
variable "key_name" {}
variable "env" {}
variable "inst_type" {}
variable "amis" {
  type = map (string)
  default = {
    "prod" = "ami-0c02fb55956c7d316" #kernel 5
    "dev" = "ami-03e0b06f01d45a4eb " #kernel 4
}
}
variable "mode" {}