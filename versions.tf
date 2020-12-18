# Terraform version
terraform {
  required_version = ">= 0.12.0, < 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.10.0"
    }
  }
}