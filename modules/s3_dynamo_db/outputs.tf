output "bucket_name" {
  description = "Name of the S3 bucket used for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  description = "Name of the existing DynamoDB table for state locking"
  value       = data.aws_dynamodb_table.terraform_lock.id
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = data.aws_dynamodb_table.terraform_lock.arn
}