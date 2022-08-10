resource "aws_s3_bucket" "data_bucket" {
  tags = var.resource_tags
}

resource "aws_s3_bucket_acl" "data_bucket" {
  bucket = aws_s3_bucket.data_bucket.id
  acl    = var.bucket_acl
}

resource "aws_s3_bucket_versioning" "data_bucket" {
  bucket = aws_s3_bucket.data_bucket.id
  
  versioning_configuration {
    status = var.versioning_enabled
  }
}