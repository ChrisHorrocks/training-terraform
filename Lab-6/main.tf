provider "aws" {
  region = "eu-west-2"
}

resource "aws_default_vpc" "default" {}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  tags     = {
      Name  = "EIP for WebServer Built by Terraform"
      Owner = "Chris Horrocks"
  }
}

resource "aws_instance" "web" {
    ami                         = "ami-0d93d81bb4899d4cf"
    instance_type               = "t2.micro"
    key_name                    = "chris_horrocks-london"
    vpc_security_group_ids      = [aws_security_group.web.id]
    user_data                   = file("user_data.sh")
    user_data_replace_on_change = true
    tags = {
        Name  = "WebServer Built by Terraform"
        Owner = "Chris Horrocks"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Security Group for my WebServer"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "Chris Horrocks"
  }
}