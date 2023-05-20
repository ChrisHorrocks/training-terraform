provider "aws" {
  region = "eu-west-2"
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "web" {
  ami                    = "ami-0d93d81bb4899d4cf"
  instance_type          = "t2.micro"
  key_name               = "chris_horrocks-london"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = <<EOF
#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install nginx -y
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with PrivateIP: $MYIP</h2><br>Built by Terraform" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx
EOF
  tags = {
    Name  = "WebServer"
    Owner = "Chris Horrocks"
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