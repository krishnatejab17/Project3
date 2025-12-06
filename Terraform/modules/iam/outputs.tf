output "execution_role_arn" {
  value = aws_iam_role.execution_role.arn
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_role.arn
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy_role.arn
}
