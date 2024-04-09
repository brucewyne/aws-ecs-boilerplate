data "aws_iam_policy_document" "ecs_task_execution" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecs_task_execution" {
  name   = "ecs_task_execution_dev"
  policy = data.aws_iam_policy_document.ecs_task_execution.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}

resource "aws_iam_role" "ecs_role" {
  name = "ecs_role_dev"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  })
}
