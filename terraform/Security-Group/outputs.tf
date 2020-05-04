output "aws_sg" {
  value = "${aws_security_group.group-project.id}"
}

# output "vpc_id" {
#   value = "${aws_vpc.vpc.id}"
# }