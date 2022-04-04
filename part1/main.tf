terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "terraform-demo-by-josh"
    key    = "part1_state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "part_1_instance" {
  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = var.instance_type
  ipv6_address_count          = var.ipv6_address_count
  associate_public_ip_address = var.associate_public_ip_address
  security_groups             = var.security_groups
  tags                        = merge(var.project_tags)
}