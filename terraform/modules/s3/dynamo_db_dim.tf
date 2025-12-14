resource "aws_s3_bucket" "dynamo_dim_bucket" {
  bucket = "dynamo-db-dim-${var.environment}"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.dynamo_dim_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
