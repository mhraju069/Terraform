resource "aws_s3_bucket" "mybucket" {
  bucket = "mhr-s3bucket-001"

  tags = {
    name = "mhr-s3bucket-001"
  }
}
