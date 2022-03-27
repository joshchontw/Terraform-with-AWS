terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "lab-03-terraform"
    key    = "part2_state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "part_2_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.SG.id}"]
  key_name                    = var.key_name
  tags                        = merge(var.project_tags)
}

### Remote SSH into the newly created instance, install Ansible, and run the copied playbook locally

resource "null_resource" "remote_connection" {
  depends_on = [aws_instance.part_2_instance]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.part_2_instance.public_ip
    private_key = file("testkey.pem")
  }

  provisioner "file" {
    source      = "hello_world.yaml"
    destination = "/tmp/hello_world.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo yum upgrade -y",
      "sudo amazon-linux-extras install ansible2 -y",
      "cd /tmp",
      "ansible-playbook hello_world.yaml"
    ]
  }
}

resource "aws_security_group" "SG" {
  name        = "SG"
  description = "Allow inbound SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}