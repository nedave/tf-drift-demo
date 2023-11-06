resource "aws_s3_bucket" "mroberts-test-bucket" {
  bucket = "mroberts-this-bucket-should-drift-20220913"
  tags = {
    yor_trace = "db130dee-0c09-4eab-80d5-b374a15edb99"
    git_org   = "nedave"
  }
}