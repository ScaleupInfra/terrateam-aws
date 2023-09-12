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
    bucket = "<your_bucket_name>"
    key    = "//path/to/file"
    region = "us-east-1"
  }
}
