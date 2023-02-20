######################               Load Balancer Security Group

resource "aws_security_group" "lb-sg" {
  name        = "${var.prefix}-${var.environment}-lb-SG"
  description = var.lb_sg_describe
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = var.lb_sg_ingress_describe
    from_port   = var.lb_sg_ingress_port
    to_port     = var.lb_sg_ingress_port
    protocol    = var.lb_sg_ingress_protocol
    cidr_blocks = ["${var.lb_sg_ingress_ip4_cidr}"]
  }

  egress {
    description      = var.lb_sg_outgress_describe
    from_port        = var.lb_sg_outgress_port
    to_port          = var.lb_sg_outgress_port
    protocol         = var.lb_sg_outgress_protocol
    cidr_blocks      = ["${var.lb_sg_outgress_ip6_cidr}"]
  }
  tags = {
    Name = "${var.prefix}-${var.environment}-lb-SG"
  }
}

###########################     ECS Service Security Group

resource "aws_security_group" "svc-sg" {
  name        = "${var.prefix}-${var.environment}-ECS-svc-SG"
  description = var.svc_sg_describe
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = var.svc_sg_ingress_describe
    from_port   = var.svc_sg_ingress_port
    to_port     = var.svc_sg_ingress_port
    protocol    = var.svc_sg_ingress_protocol
    security_groups = ["${aws_security_group.lb-sg.id}"]
  }

  egress {
    description      = var.svc_sg_outgress_describe
    from_port        = var.svc_sg_outgress_port
    to_port          = var.svc_sg_outgress_port
    protocol         = var.svc_sg_outgress_protocol
    cidr_blocks      = ["${var.svc_sg_outgress_ip6_cidr}"]
  }
  tags = {
    Name = "${var.prefix}-${var.environment}-ECS-svc-SG"
  }
}

###########################     RDS Security Group

resource "aws_security_group" "rds-sg" {
  name        = "${var.prefix}-${var.environment}-RDS-SG"
  description = var.rds_sg_describe
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = var.rds_sg_ingress_describe
    from_port   = var.rds_sg_ingress_port
    to_port     = var.rds_sg_ingress_port
    protocol    = var.rds_sg_ingress_protocol
    security_groups = ["${aws_security_group.svc-sg.id}"]
  }

  egress {
    description      = var.rds_sg_outgress_describe
    from_port        = var.rds_sg_outgress_port
    to_port          = var.rds_sg_outgress_port
    protocol         = var.rds_sg_outgress_protocol
    cidr_blocks      = ["${var.rds_sg_outgress_ip6_cidr}"]
  }
  tags = {
    Name = "${var.prefix}-${var.environment}-RDS-SG"
  }
}