variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "trigger_bucket_id" {
  type        = string
  description = "Lambda triggering bucket ID"
}

variable "trigger_bucket_arn" {
  type        = string
  description = "Lambda triggering bucket ARN"
}
