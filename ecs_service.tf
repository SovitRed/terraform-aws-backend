resource "aws_ecs_service" "svc" {
  name                    = "${aws_ecs_cluster.cluster.name}-svc"
  cluster                 = aws_ecs_cluster.cluster.id
  launch_type             = "FARGATE"
  task_definition         = aws_ecs_task_definition.task_define.arn
  desired_count           = var.svc_desire_count
  force_new_deployment    = var.force_new_deployment

  network_configuration {
    assign_public_ip = var.svc_network_assign_ip
    security_groups  = [aws_security_group.svc-sg.id]
    subnets          = [aws_subnet.private_subnet-1.id]
  }
  enable_ecs_managed_tags = var.svc_enable_ecs_tags

  load_balancer {
    target_group_arn = aws_alb_target_group.TG.arn
    container_name   = "${var.prefix}-${var.ecr_img_name}"
    container_port   = var.svc_lb_container_port
  }
  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy]

}

