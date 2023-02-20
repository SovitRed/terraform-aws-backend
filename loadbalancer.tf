resource "aws_alb" "ALB" {
  name            = "${var.prefix}-${var.environment}-lb"
  subnets         = [aws_subnet.public_subnet-1.id, aws_subnet.public_subnet-2.id]
  security_groups = [aws_security_group.lb-sg.id]
}

resource "aws_alb_target_group" "TG" {
  name        = "${var.prefix}-${var.environment}-tg"
  port        = var.tg_port
  protocol    = var.tg_protocol
  vpc_id      = aws_vpc.vpc.id
  target_type = var.tg_target_type

  health_check {
    healthy_threshold   = var.health_threshold
    interval            = var.health_check_interval
    protocol            = var.health_check_protocol
    matcher             = var.health_check_matcher
    timeout             = var.health_check_timeout
    path                = var.health_check_path
    unhealthy_threshold = var.unhealthy_threshold
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.ALB.id
  port              = var.lb_listerner_port
  protocol          = var.lb_listerner_protocol

  default_action {
    target_group_arn = aws_alb_target_group.TG.id
    type             = var.lb_listerner_type
  }
}