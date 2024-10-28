variable "ami_id" {
  type        = string
  default     = "ami-0bcf98c2c6db6c5f4"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "sshkey" {
  type = string
  default = "myssh"
}

variable "ec2_name" {
  default = "task"
}