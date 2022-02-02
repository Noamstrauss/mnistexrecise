variable "noams_key_name" {
  description = "Noam's_Private_key_name"
  type        = string
  default     = "ohio-int-account"
}

variable "ami" {
  description = "AMI image"
  type        = string
  default    = "ami-001089eb624938d9f"

}


variable "name" {
  description = "Instance name"
  type        = string
  default     = "dev-ec2"
}


variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}
