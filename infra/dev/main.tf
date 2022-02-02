terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}



module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name           = "dev-ec2"

  ami                    = "ami-001089eb624938d9f"
  instance_type          = "t2.micro"
  key_name               = "user1"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}