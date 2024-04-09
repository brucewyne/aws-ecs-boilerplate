provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    # rename this to your unique bucket name.
    # you can use the same bucket, but keep the the key separate.
    bucket = "myorg-terraform-infrastructure"
    key    = "infrastructure-dev"
    region = "us-east-1"
  }
}
