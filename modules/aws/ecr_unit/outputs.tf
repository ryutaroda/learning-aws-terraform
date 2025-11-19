output "aws_ecr_uri" {
  value = aws_ecr_repository.learning_app.repository_url
}