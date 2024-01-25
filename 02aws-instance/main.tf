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
  ami           = "ami-0fc0ab6d7593a9bd9"
  instance_type = "t1.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}