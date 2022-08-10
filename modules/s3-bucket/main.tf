resource "aws_s3_bucket" "data_bucket" {
  acl = var.bucket_acl
  
  versioning {
    enabled = var.versioning_enabled
  }

  tags = var.resource_tags
}