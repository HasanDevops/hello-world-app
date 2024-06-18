variable "docker_image" {
  description = "Docker image for the container"
  type        = string
}

resource "aws_ecs_task_definition" "hello_world" {
  family                = "hello-world-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "256"
  memory                = "512"

  container_definitions = jsonencode([
    {
      name      = "hello-world-container"
      image     = var.docker_image  # Ensure this variable is correctly used
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}
