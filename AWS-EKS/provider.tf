terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

  provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "834277767437-tf-state"
    key    = "EKS/eks.tfstate"
    region = "us-east-1"
  }
}