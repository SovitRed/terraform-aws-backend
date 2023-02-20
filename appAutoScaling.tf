resource "aws_appautoscaling_target" "scale_target" {
  service_namespace  = var.ASG_svc_namespace
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.svc.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.ASG_max_capacity
  min_capacity       = var.ASG_min_capacity
}


##################   CPU Utilization  ###################

resource "aws_appautoscaling_policy" "auto-scale" {
  name               = var.cpu_policy_name              
  policy_type        = var.ASG_policy_type
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.ASG_predefined_metric_type
    }

    target_value       = var.ASG_target_value
    scale_out_cooldown = var.ASG_scale_out_cooldown
    scale_in_cooldown  = var.ASG_scale_in_cooldown
  }
  depends_on = [aws_appautoscaling_target.scale_target]
}

######################  Memory Utilization  #########################

resource "aws_appautoscaling_policy" "memory_utilize" {
  #name               = "ecsappscaling:${aws_appautoscaling_target.memory_scale_target.resource_id}"
  name               = var.memory_policy_name
  policy_type        = var.ASG_policy_type
  service_namespace  = aws_appautoscaling_target.scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.scale_target.scalable_dimension

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.ASG_memory_predefined_metric_type
    }

    target_value       = var.ASG_memory_target_value
    scale_out_cooldown = var.ASG_memory_scale_out_cooldown
    scale_in_cooldown  = var.ASG_memory_scale_in_cooldown
  }
  depends_on = [aws_appautoscaling_target.scale_target]
}


