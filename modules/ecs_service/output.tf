# output "task_definition_arn" {
#   description = "The ARN of the created ECS task definition."
#   value       = aws_ecs_task_definition.snipeit-task-definition.arn
# }
############################################################
/*output "iam_role_arn" {
  value       = join("", aws_iam_role.default.*.arn)
  description = "The Amazon Resource Name (ARN) specifying the IAM Role."
}

output "iam_role_create_date" {
  value       = join("", aws_iam_role.default.*.create_date)
  description = "The creation date of the IAM Role."
}

output "iam_role_unique_id" {
  value       = join("", aws_iam_role.default.*.unique_id)
  description = "The stable and unique string identifying the IAM Role."
}

output "iam_role_name" {
  value       = join("", aws_iam_role.default.*.name)
  description = "The name of the IAM Role."
}

output "iam_role_description" {
  value       = join("", aws_iam_role.default.*.description)
  description = "The description of the IAM Role."
}

output "iam_policy_id" {
  value       = join("", aws_iam_policy.default.*.id)
  description = "The IAM Policy's ID."
}

output "iam_policy_arn" {
  value       = join("", aws_iam_policy.default.*.arn)
  description = "The ARN assigned by AWS to this IAM Policy."
}

output "iam_policy_description" {
  value       = join("", aws_iam_policy.default.*.description)
  description = "The description of the IAM Policy."
}

output "iam_policy_name" {
  value       = join("", aws_iam_policy.default.*.name)
  description = "The name of the IAM Policy."
}

output "iam_policy_path" {
  value       = join("", aws_iam_policy.default.*.path)
  description = "The path of the IAM Policy."
}

output "iam_policy_document" {
  value       = join("", aws_iam_policy.default.*.policy)
  description = "The policy document of the IAM Policy."
} */
