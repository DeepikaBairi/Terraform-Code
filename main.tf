//Provider configuration
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version ="~>3.0"
        }
    }
}
provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_instance" "WebServer1" {
    ami = "ami-0dc5785603ad4ff54"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    availability_zone = "ap-southeast-1a"
    ebs_block_device {
        delete_on_termination = true
        device_name = "/dev/xvda"
        encrypted = false
      volume_size = "8"
      volume_type = "gp2"
          }
          security_groups = ["Webtier"]
          subnet_id = "subnet-bb7459dc"
        key_name = "MyEc2KeyPair"

    tags                                 = {
          "Name" = "WebServer1"
    }
}
resource "aws_instance" "WebServer2" {
    ami = "ami-0dc5785603ad4ff54"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    availability_zone = "ap-southeast-1b"
    ebs_block_device {
        delete_on_termination = true
        device_name = "/dev/xvda"
        encrypted = false
      volume_size = "8"
      volume_type = "gp2"
          }
          security_groups = ["sg-04787e19771fec9b3"]
          subnet_id = "subnet-f699cbbf"
        key_name = "MyEc2KeyPair"

    tags                                 = {
          "Name" = "WebServer2"
    }
}
resource "aws_instance" "WordPressServer1" {
    ami = "ami-0dc5785603ad4ff54"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    availability_zone = "ap-southeast-1a"
    ebs_block_device {
        delete_on_termination = true
        device_name = "/dev/xvda"
        encrypted = false
      volume_size = "8"
      volume_type = "gp2"
          }
          security_groups = ["sg-004cb02d13a5c667f"]
          subnet_id = "subnet-bb7459dc"
        key_name = "MyEc2KeyPair"

    tags                                 = {
          "Name" = "WordPressServer1"
    }
}
resource "aws_instance" "WordPressServer2" {
    ami = "ami-0dc5785603ad4ff54"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    availability_zone = "ap-southeast-1b"
    ebs_block_device {
        delete_on_termination = true
        device_name = "/dev/xvda"
        encrypted = false
      volume_size = "8"
      volume_type = "gp2"
          }
          security_groups = ["sg-004cb02d13a5c667f"]
          subnet_id = "subnet-f699cbbf"
        key_name = "MyEc2KeyPair"

    tags                                 = {
          "Name" = "WordPressServer2"
    }
}