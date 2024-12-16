resource "aws_iam_role_policy" "sagemaker_execution_role_policy" {
  name = "${var.model_name}-sagemaker-execution-role-policy"
  role = aws_iam_role.model_execution_role.name

  policy = jsonencode({
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken"
        ],
        Resource = var.model_repository_arn
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = aws_cloudwatch_log_group.model_log_group.arn
      }
    ]
  })
}
resource "aws_iam_role" "model_execution_role" {
  name = "${var.model_name}-sagemaker-execution-role"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "SagemakerModelAssumeRole"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      }
    ]
  })
}