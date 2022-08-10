resource "aws_s3_bucket" "data_bucket" {
  tags = var.resource_tags
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.data_bucket.id
  acl    = var.bucket_acl
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.data_bucket.id
  
  versioning_configuration {
    status = var.versioning_enabled
  }
}