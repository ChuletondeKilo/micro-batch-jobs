resource "aws_dynamodb_table" "microbatch_fact_request" {
  name         = "microbatch_fact_request"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "request_id"
  range_key    = "request_generation_timestamp"

  # attribute {
  #   name = "job_id"
  #   type = "S"
  # }

  attribute {
    name = "request_id"
    type = "S"
  }
  # Map type attributes will be inserted by the application. Won't be defined at enforced-schema level
  # attribute {
  #   name = "request_params"
  #   type = "M"
  # }

  # attribute {
  #   name = "execution_status"
  #   type = "M"
  # }

  attribute {
    name = "request_generation_timestamp"
    type = "S"
  }

  tags = {
    Name        = "microbatch_fact_request"
    Environment = var.environment
  }
}
