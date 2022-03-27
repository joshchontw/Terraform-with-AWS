terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "lab-03-terraform"
    key    = "part3_state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_stack" {
  source = "./webserver_setup"
  project_tags =  {
    Name       = "webserver_stack_demo"
    Owner      = "Josh Cho"
    Purpose    = "Lab"
  }
}