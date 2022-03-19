# output "Public-Ip_Slave" {
#   description = "List of IDs of instances"
#   value       = ["${var.tag_name1}", "=", "${aws_instance.server1.*.public_ip}"]
# }

output "Public-Ips_Master" {
  description = "List of IDs of instances"
  value       = ["${var.tag_name2}", "=", "${aws_instance.server2.*.public_ip}"]
}

# output "Private-Ip_Slave" {
#   description = "List of IDs of instances"
#   value       = ["${var.tag_name1}", "=", "${aws_instance.server1.*.private_ip}"]
# }

output "Private-Ips_Master" {
  description = "List of IDs of instances"
  value       = ["${var.tag_name2}", "=", "${aws_instance.server2.*.private_ip}"]
}