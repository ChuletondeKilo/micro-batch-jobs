resource "aws_dynamodb_table" "microbatch_dim_source" {
  name         = "microbatch_dim_source"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "source_id"

  attribute {
    name = "source_id"
    type = "S"
  }

  # attribute {
  #   name = "connection_type"
  #   type = "S"
  # }

  # Map type attributes will be inserted by the application. Won't be defined at enforced-schema level
  # attribute {
  #   name = "connection_params"
  #   type = "M"
  # }

  # attribute {
  #   name = "delta_split_params"
  #   type = "M"
  # }

  # attribute {
  #   name = "created_at"
  #   type = "S"
  # }

  # attribute {
  #   name = "modified_at"
  #   type = "S"
  # }

  tags = {
    Name        = "microbatch_dim_source"
    Environment = var.environment
  }
}
