# please enter your access and secret key from aws account

terraform {

  required_providers {
   
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
  access_key = "xxxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}


# create s3 bucket
resource "aws_s3_bucket" "test" {
  bucket_prefix = "${var.project_name}"
  force_destroy = true
}

