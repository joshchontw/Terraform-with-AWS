variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ipv6_address_count" {
  type    = number
  default = 0
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "security_groups" {
  type    = list(any)
  default = ["default"]
}

variable "project_tags" {
  type = map(string)
  default = {
    Name    = "part1-testing"
    Owner   = "Josh Cho"
    Purpose = "Lab"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}