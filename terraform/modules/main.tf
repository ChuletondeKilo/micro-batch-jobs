module "s3" {
  source      = "./s3"
  environment = var.environment
}

module "dynamodb" {
  source      = "./dynamodb"
  environment = var.environment
}
