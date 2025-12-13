resource "aws_dynamodb_table" "microbatch_fact_job" {
  name         = "microbatch_fact_job"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "job_id"
  range_key    = "job_generation_timestamp"

  # attribute {
  #   name = "execution_id"
  #   type = "S"
  # }

  attribute {
    name = "job_id"
    type = "S"
  }
  # Map/Enum type attributes will be inserted by the application. Won't be defined at enforced-schema level
  # attribute {
  #   name = "source_id"
  #   type = "SS"
  # }

  # attribute {
  #   name = "data_to_fetch"
  #   type = "M"
  # }

  attribute {
    name = "job_generation_timestamp"
    type = "S"
  }

  tags = {
    Name        = "microbatch-job-fact-table"
    Environment = var.environment
  }
}
