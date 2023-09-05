# file name: main.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "ap-northeast-1"
  access_key = "AKIARQSGNPPR42UYOQO7"
  secret_key = "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"
}
resource "aws_s3_bucket" "infraSity" {
  bucket = lower("infraSity")
  acl = "private"
  versioning {
    enabled = true
  }
}
