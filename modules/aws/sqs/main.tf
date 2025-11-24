resource "aws_sqs_queue" "learning_app" {
  name = "learning-app-queue-${var.env}"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "arn:aws:sqs:ap-northeast-1:${var.account_id}:learning-app-queue-dlq-${var.env}"
    maxReceiveCount     = 3
  })
  tags = {
    Name = "learning-app-queue-${var.env}"
  }
}

resource "aws_sqs_queue_policy" "learning_app" {
  queue_url = aws_sqs_queue.learning_app.url
  policy = jsonencode({
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${var.account_id}:root"
      }
      Resource = aws_sqs_queue.learning_app.arn
    }]
    Version = "2012-10-17"
  })
}

resource "aws_sqs_queue" "learning_app_dlq" {
  name = "learning-app-queue-dlq-${var.env}"
  tags = {
    Name = "learning-app-queue-dlq-${var.env}"
  }
}

resource "aws_sqs_queue_policy" "learning_app_dlq" {
  queue_url = aws_sqs_queue.learning_app_dlq.url
  policy = jsonencode({
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${var.account_id}:root"
      }
      Resource = aws_sqs_queue.learning_app_dlq.arn
    }]
    Version = "2012-10-17"
  })
}
