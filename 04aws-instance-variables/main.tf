terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "cn-north-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-03290f6be222b4fb2"
  instance_type = "t1.micro"

  tags = {
    Name = var.instance_name
  }
}