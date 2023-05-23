provider "aws" {
  region = "eu-west-1"
}


data "aws_ami" "latest_ubuntu20" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


resource "aws_instance" "server_ubuntu" {
  ami           = data.aws_ami.latest_ubuntu20.id
  instance_type = "t3.micro"
}


output "latest_ubuntu20_ami_id" {
  value = data.aws_ami.latest_ubuntu20.id
}
