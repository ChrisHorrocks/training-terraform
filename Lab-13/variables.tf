variable "aws-region" {
    description       = "AWS Region to provision resources into."
    type              = string
    validation {
      condition       = contains(["eu-west-1", "eu-west-2"], var.aws-region)
      error_message   = "Invalid AWS Region."
    }
}