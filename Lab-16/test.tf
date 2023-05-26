
resource "aws_instance" "api" {
  ami                    = "ami-0d93d81bb4899d4cf"
  instance_type          = var.aws-ec2-instance-slug
  key_name               = "chris_horrocks-london"
  vpc_security_group_ids = [aws_security_group.web.id]
}