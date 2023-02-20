resource "aws_ecs_task_definition" "task_define" {
  family                   = "${var.prefix}-${var.environment}-task-define"
  requires_compatibilities = ["FARGATE"]
  network_mode             = var.TD_network_mode
  cpu                      = var.TD_cpu
  memory                   = var.TD_memory
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn

  task_role_arn = aws_iam_role.ecsTaskExecutionRole.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = <<DEFINITION
[
    {
        "name": "${var.prefix}-app",
        "image": "${aws_ecr_repository.ecr-repo.repository_url}:${var.ecr_img_name}",
        "essential": ${var.TD_container_defination_essential},
        "portMappings": [
            {
                "protocol": "${var.TD_container_defination_protocol}",
                "memoryReservation": "${var.soft_limit}",
                "containerPort": ${var.TD_container_defination_containerPort},
                "hostPort": ${var.TD_container_defination_hostPort}
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "secretOptions": null,
            "options": {
                    "awslogs-group": "/ecs/${var.prefix}-${var.environment}-task-define",
                    "awslogs-region": "${var.region}",
                    "awslogs-stream-prefix": "ecs"
                }
        }
    }
]
DEFINITION
}


########################  CLOUDWATCH  Logs group of container ######################

resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.prefix}-${var.environment}-task-define"
  retention_in_days = var.retention_in_days
  tags = {
    "env"       = var.environment
  }
}
