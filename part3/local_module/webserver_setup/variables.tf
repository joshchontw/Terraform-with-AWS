variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami" {
  type    = string
  default = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "testkey"
}

variable "project_tags" {
  type = map(string)
  default = {
    Name    = "part3-testing"
    Owner   = "Josh Cho"
    Purpose = "Lab"
  }
}