resource "aws_iam_role" "nat" {
  name = "learning-nat-instance-role-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description = "Allows EC2 instances to call AWS services on your behalf."

}
resource "aws_iam_instance_profile" "nat_profile" {
  name = aws_iam_role.nat.name
  role = aws_iam_role.nat.name
}

resource "aws_iam_role" "bastion" {
  name = "learning-bastion-role-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description = "Allows EC2 instances to call AWS services on your behalf."
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = aws_iam_role.bastion.name
  role = aws_iam_role.bastion.name
}

resource "aws_iam_role" "github_actions_role" {
  name = "learning-github-actions-role-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
        StringLike = {
          "token.actions.githubusercontent.com:sub" = ["repo:ryutaroda/learning-aws-app:*", "repo:ryutaroda/learning-aws-app:*"]
        }
      }
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role" "ecs_task_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Sid = ""
    }]
    Version = "2012-10-17"
  })
  description           = "Allows ECS tasks to call AWS services on your behalf."
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "learning-ecs-task-role-${var.env}"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}

resource "aws_iam_role" "ecs_task_execution_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Sid = ""
    }]
    Version = "2012-10-17"
  })
  description = "Allows ECS tasks to call AWS services on your behalf."
  name        = aws_iam_role.ecs_task_execution_role.name
}

# ecs_task_execution_roleのinline policy
resource "aws_iam_role_policy" "task_execution_role_s3_env_file_access" {
  name = "S3EnvFileAccess"
  role = "learning-ecs-task-execution-role-${var.env}"
  policy = jsonencode({
    Statement = [{
      Action   = ["s3:GetObject"]
      Effect   = "Allow"
      Resource = ["arn:aws:s3:::learning-ryutaro-config-stg/learning-stg.env"]
      }, {
      Action   = ["s3:GetBucketLocation"]
      Effect   = "Allow"
      Resource = ["arn:aws:s3:::learning-ryutaro-config-${var.env}"]
    }]
    Version = "2012-10-17"
  })
}
