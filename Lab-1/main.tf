# PROVIDERS
provider "aws" {
    region = "eu-west-2"
}

# RESOURCES
resource "aws_instance" "test_vm" {
    ami = "ami-09744628bed84e434"

    instance_type = "t2.micro"

    key_name = "chris_horrocks-london"

    tags = {
        Name = "Test VM"
        Owner = "Chris Horrocks"
    }
}
