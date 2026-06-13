terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.28.0"
    }
  }

  backend "s3" {
    bucket         = "mhr-s3bucket-001"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    use_lockfile   = true
    dynamodb_table = "remote-terra-table"
  }
}
