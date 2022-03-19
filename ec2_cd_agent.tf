# ###### slave

# resource "aws_instance" "server1" {
#   ami = "${lookup(var.amis, var.env, "")}"
#   instance_type = "${var.inst_type}"
#   count = "${lookup(var.instance_count, var.mode)}"
#   associate_public_ip_address = "true"
#   availability_zone = "${element(var.availablity_zones, count.index)}"
#   subnet_id = "${element(aws_subnet.public_subnets.*.id, count.index)}"
#   vpc_security_group_ids = ["${aws_security_group.SG.id}"]
#   tags = {
#     "Name" = "${var.tag_name1}-${count.index + 1}"
#     "type" = "${var.env}"
#     "mode" = "${var.mode}"
#   }
#   key_name = "${var.key_name}"
#   # user_data = "${file("codedeploy_agent.sh")}"

#   provisioner "file" {
#     source      = "codedeploy_agent.sh"
#     destination = "/root"

#     connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     private_key = "${file("MainKey.pem")}"
#     host     = "${element(aws_instance.server1.*.public_ip, count.index)}"
#     }
#   }

#   provisioner "remote-exec" {
#       inline = [
#       "sudo su -",
#       "chmod +x codedeploy_agent.sh",
#       "bash codedeploy_agent.sh",
#     ]
#   }
# }

####### Master

resource "aws_instance" "server2" {
  ami = "${lookup(var.amis, var.env, "")}"
  instance_type = "${var.inst_type}"
  count = "${lookup(var.instance_count, var.mode)}"
  associate_public_ip_address = "true"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  availability_zone = "${element(var.availablity_zones, count.index)}"
  subnet_id = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.SG.id}"]
  tags = {
    "Name" = "${var.tag_name2}-${count.index + 1}"
    "type" = "${var.env}"
    "mode" = "${var.mode}"
  }
  key_name = "${var.key_name}"
  user_data = "${file("jenkins_maven_java.sh")}"

  provisioner "remote-exec" {
      inline = [
        "sudo yum update -y",
        "sudo yum install ruby -y",
        "sudo yum install wget -y",
        "cd /home/ec2-user",
        "wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install",
        "chmod +x ./install",
        "sudo ./install auto",
        "sudo service codedeploy-agent start"
    ]

    
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("MainKey.pem")}"
    host     = "${element(aws_instance.server2.*.public_ip, count.index)}"
    }
  }
}

