resource "aws_ecr_repository" "learning_app" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"
  tags = {
    Name = var.name
  }
}

resource "aws_ecr_lifecycle_policy" "retain_latest_images" {
  repository = aws_ecr_repository.learning_app.name
  policy = jsonencode({
    rules = [{
      action = {
        type = "expire"
      }
      description  = "最新の3世代のイメージのみを保持"
      rulePriority = 1
      selection = {
        countNumber = 3
        countType   = "imageCountMoreThan"
        tagStatus   = "any"
      }
    }]
  })
}
