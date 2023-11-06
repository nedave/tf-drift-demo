resource "aws_s3_bucket" "data_bucket" {
  tags = merge(var.resource_tags, {
    yor_trace = "7e306107-f0bc-4b08-91fc-db83d8785ec1"
    }, {
    git_org = "nedave"
  })
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