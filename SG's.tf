resource "aws_security_group" "SG" {
  name = "Terraform_SG"
  description = "SSH,TCP,HTTPS"
  vpc_id = aws_vpc.VPC.id

  ingress {
    cidr_blocks = [ "${var.ingress_cidr}" ]
    description = "SSH"
    from_port = 22
    protocol = "tcp"
    self = false
    to_port = 22
  }

  ingress {
    cidr_blocks = [ "${var.ingress_cidr}" ]
    description = "jenkins"
    from_port = 8080
    protocol = "tcp"
    self = false
    to_port = 8080
  }
  
  ingress {
    cidr_blocks = [ "${var.ingress_cidr}" ]
    description = "HTTP"
    from_port = 80
    protocol = "tcp"
    self = false
    to_port = 80
  } 

    ingress {
    cidr_blocks = [ "${var.ingress_cidr}" ]
    description = "HTTPS"
    from_port = 443
    protocol = "tcp"
    self = false
    to_port = 443
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }

tags = {
  "Name" = "terraform_SG"
}
}