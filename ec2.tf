resource "aws_instance" "servers" {
  ami = "${lookup(var.amis, var.env, "")}"
  instance_type = "${var.inst_type}"
  count = "${lookup(var.instance_count, var.mode, "slave")}"
  associate_public_ip_address = "true"
  availability_zone = "${element(var.availablity_zones, count.index)}"
  subnet_id = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.SG.id}"]
  tags = {
    "Name" = "Terraform-${count.index + 1}"
    "type" = "${var.env}"
    "mode" = "${var.mode}"
  }
  key_name = "${var.key_name}"
  user_data = "${file("jenkins_maven_java.sh")}"
}

resource "aws_instance" "servers" {
  ami = "${lookup(var.amis, var.env, "")}"
  instance_type = "${var.inst_type}"
  count = "${lookup(var.instance_count, var.mode, "master")}"
  associate_public_ip_address = "true"
  availability_zone = "${element(var.availablity_zones, count.index)}"
  subnet_id = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.SG.id}"]
  tags = {
    "Name" = "Terraform-${count.index + 1}"
    "type" = "${var.env}"
    "mode" = "${var.mode}"
  }
  key_name = "${var.key_name}"
  user_data = "${file("jenkins_maven_java.sh")}"
}

