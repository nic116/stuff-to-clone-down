resource "aws_instance" "instance_1" {
  ami                    = var.ami_id
  instance_type          = var.t2_micro
  subnet_id              = var.aws_subnetsEC2
  vpc_security_group_ids = var.sg
  key_name               = var.key_name


provisioner "local-exec" {
    command = "echo ${aws_instance.instance_1.public_ip} > ip_address.txt"
  }
 }