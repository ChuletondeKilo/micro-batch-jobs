# module "sqs" {
#   source      = "./sqs"
#   environment = var.environment
# }

module "s3" {
  source      = "./s3"
  environment = var.environment
  # depends_on  = [module.sqs]
}

module "lambda" {
  source             = "./lambda"
  environment        = var.environment
  trigger_bucket_id  = module.s3.dynamo_db_dim_bucket_id
  trigger_bucket_arn = module.s3.dynamo_db_dim_bucket_arn
  depends_on         = [module.s3]
}

module "dynamodb" {
  source      = "./dynamodb"
  environment = var.environment
}
