terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "lab-03-terraform"
    key    = "part3b_state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc_stack" {
  source = "github.com/joshchontw/AWS_VPC_Terraform_module"
}