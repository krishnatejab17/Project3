terraform {
  required_version = ">= 1.5.0"
}

resource "aws_ecr_repository" "this" {
  name = "${var.app_name}-${var.environment}-ecr"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-ecr"
    Environment = var.environment
  }
}
