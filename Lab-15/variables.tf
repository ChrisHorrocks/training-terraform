variable "aws-region" {
    description       = "AWS Region to provision resources into."
    type              = string
    validation {
      condition       = contains(["eu-west-1", "eu-west-2"], var.aws-region)
      error_message   = "Invalid or Unapproved AWS Region."
    }
}

variable "aws-ec2-instance-slug" {
    description   = "AWS EC2 Instance size."
    type          = string
    default       = "t3.micro"
}

variable "aws-tags-default" {
    description   = "AWS Tags default set."
    type          = map(string)
    default       = {
      Owner       = "Chris Horrocks"
      CreatedBy   = "Terraform"
    }
}

variable "aws-sg-web-ports-default" {
    description   = "AWS Security Group Web default ingress ports."
    type          = list(string)
    default       = ["80", "443"]
}