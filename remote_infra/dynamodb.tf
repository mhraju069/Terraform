module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "remote-terra-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  tags = {
    Terraform   = "remote-infra"
  }
}