data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "data_loader_lambda_iam" {
  name               = "data_loader_lambda_iam"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.trigger_bucket_arn
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../../packages/file-loader" # Point to your code
  output_path = "${path.module}/file-loader.zip"
}

resource "aws_lambda_function" "func" {
  function_name    = "file-loader"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.data_loader_lambda_iam.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.12"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.trigger_bucket_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/"
    filter_suffix       = ".log"
  }


  depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_cloudwatch_log_group" "func_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.func.function_name}"
  retention_in_days = 7
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.data_loader_lambda_iam.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
