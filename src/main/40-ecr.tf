locals {
  cms_repository = "cms-ecr"
}

resource "aws_ecr_repository" "main" {
  name = local.cms_repository

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = { "Name" : local.cms_repository }

}

resource "aws_ecr_lifecycle_policy" "main" {

  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = format("Keeps last %s images", var.ecr_keep_nr_images)
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = var.ecr_keep_nr_images
      }
    }]
  })
}