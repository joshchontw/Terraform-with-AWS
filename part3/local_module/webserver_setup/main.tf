terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "part_3a_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.SG.id}"]
  key_name                    = var.key_name
  tags                        = merge(var.project_tags)
}

resource "null_resource" "remote_connection" {
  depends_on = [aws_instance.part_3a_instance]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.part_3a_instance.public_ip
    private_key = file("testkey.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo yum upgrade -y",
      "sudo yum install -y httpd",
      "sudo chmod 777 /var/www/html -R",
      "sudo echo '<html><body><h1>This is Joshs software-defined webserver</h1></body></html>' > /var/www/html/index.html",
      "sudo systemctl restart httpd",
      "curl 127.0.0.1"
    ]
  }
}

resource "aws_security_group" "SG" {
  name        = "SG"
  description = "Allow inbound HTTP/SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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