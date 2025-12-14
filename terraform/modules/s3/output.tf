output "dynamo_db_dim_bucket_id" {
  value = aws_s3_bucket.dynamo_dim_bucket.id
}

output "dynamo_db_dim_bucket_arn" {
  value = aws_s3_bucket.dynamo_dim_bucket.arn
}
