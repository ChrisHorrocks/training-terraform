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
}

variable "aws-tags-default" {
    description   = "AWS Tags default set."
    type          = map(string)
}

variable "aws-sg-web-ports-default" {
    description   = "AWS Security Group Web default ingress ports."
    type          = list(string)
}

variable "aws-sg-web-ingress-cidr-default" {
    description   = "AWS Security Group Web default ingress CIDR blocks."
    type          = list(string)
}

variable "aws-sg-web-egress-cidr-default" {
    description   = "AWS Security Group Web default egress CIDR blocks."
    type          = list(string)
}

variable "aws-ami-amazon-linux-owner" {
  description   = "AWS AMI Owner for Amazon Linux."
  type          = list(string)
}

variable "aws-ami-amazon-linux-name" {
  description   = "AWS AMI Owner for Amazon Linux."
  type          = list(string)
}