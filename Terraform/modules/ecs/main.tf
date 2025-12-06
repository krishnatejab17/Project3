terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.region
}

##############################
# ECS Cluster
##############################
resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-${var.environment}-cluster"

  tags = {
    Name        = "${var.app_name}-${var.environment}-cluster"
    Environment = var.environment
  }
}

##############################
# ECS Task Definition
##############################
resource "aws_ecs_task_definition" "task" {
  family                   = "${var.app_name}-${var.environment}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.app_name}-container"
      image     = var.image_url
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

##############################
# Security Group for ECS
##############################
resource "aws_security_group" "ecs_sg" {
  name        = "${var.app_name}-${var.environment}-ecs-sg"
  description = "Allow ALB to reach ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [var.alb_security_group] # added next
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-ecs-sg"
    Environment = var.environment
  }
}

##############################
# ECS Service (Load Balanced)
##############################
resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-${var.environment}-ecs-service"
  cluster         = aws_ecs_cluster.this.id
  desired_count   = 1
  launch_type     = "FARGATE"
  platform_version = "LATEST"
  
  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.ecs_sg.id]
  }
}
