variable "aws_subnetsEC2" {
  
}

variable "sg" {
  
}

variable "ami_id" {
  default = "ami-08c757228751c5335"

}

variable "t2_micro" {
  #chanche this into a medium
  default = "t2.micro"
}

variable "key_name" {
  default = "nic1"
}