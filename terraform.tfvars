###########   Credential  ##########################

region                              = "us-east-1"

prefix                              = "home-inspection"
environment                         = "prod"


###########    VPC   #########################

enable_dns_support                  = true
enable_dns_hostnames                = true
instance_tenancy                    = "default"

aws_vpc_cidr                        = "192.168.0.0/16"
public_subnet-1_cidr                = "192.168.1.0/24"
public_subnet-2_cidr                = "192.168.2.0/24"
private_subnet-1_cidr               = "192.168.3.0/24"
private_subnet-2_cidr               = "192.168.4.0/24"
rt_cidr                             = "0.0.0.0/0"

public_subnet_availability_zone-1   = "us-east-1a"
public_subnet_availability_zone-2   = "us-east-1b"
private_subnet_availability_zone-1  = "us-east-1a"
private_subnet_availability_zone-2  = "us-east-1b"


#############################    SECURITY GROUP ##############

#>>>>>>>>>>>>>>>>>>> load balancer security group #####################3

lb_sg_describe                      = "Allow Load balancer HTTP protocol inbound rule"

## => ingress port 80
lb_sg_ingress_describe              = "HTTP port"
lb_sg_ingress_port                  = "8080"
lb_sg_ingress_protocol              = "tcp"
lb_sg_ingress_ip4_cidr              = "0.0.0.0/0"

## => outgress All Traffic port 0
lb_sg_outgress_describe             = "All Traffic rule"
lb_sg_outgress_port                 = "0"
lb_sg_outgress_protocol             = "-1"
lb_sg_outgress_ip6_cidr             = "0.0.0.0/0"



##################3 ECS Service security group #########################

svc_sg_describe                     = "Allow ECS Service HTTP protocol inbound rule"

## => ingress port 80
svc_sg_ingress_describe             = "HTTP port"
svc_sg_ingress_port                 = "8080"
svc_sg_ingress_protocol             = "tcp"
#svc_sg_ingress_ip4_cidr             = "0.0.0.0/0"

##  outgress All Traffic port 0 ################
svc_sg_outgress_describe            = "All Traffic rule"
svc_sg_outgress_port                = "0"
svc_sg_outgress_protocol            = "-1"
svc_sg_outgress_ip6_cidr            = "0.0.0.0/0"


##############  RDS Security Group ####################

rds_sg_describe                     = "Allow mysql protocol inbound rule"

## => ingress port 3306
rds_sg_ingress_describe             = "mysql port"
rds_sg_ingress_port                 = "3306"
rds_sg_ingress_protocol             = "tcp"


## => outgress All Traffic port 0
rds_sg_outgress_describe            = "All Traffic rule"
rds_sg_outgress_port                = "0"
rds_sg_outgress_protocol            = "-1"
rds_sg_outgress_ip6_cidr            = "0.0.0.0/0"


###############    ECR  #########################

ecr_img_tag_mutability              = "MUTABLE"
ecr_img_sacn_on_push                = true
ecr_img_name                        = "app" 

###############  TASK DEFINATION  ###############################

TD_network_mode                     = "awsvpc"
TD_cpu                              = "2048"
TD_memory                           = "4096"

TD_container_defination_essential   = true
TD_container_defination_protocol    = "tcp" 
TD_container_defination_containerPort = 8080
TD_container_defination_hostPort    = 8080
soft_limit                          = "512"

retention_in_days                   = 30

#####################   ECS SVC  #####################################

svc_desire_count                    = "0"
force_new_deployment                = true
svc_network_assign_ip               = false
svc_enable_ecs_tags                 = true
svc_lb_container_port               = "8080"


###########################  loadbalancer  ##########################

tg_port                             = 8080
tg_protocol                         = "HTTP"
tg_target_type                      = "ip"
health_threshold                    = 3
health_check_interval               = 30
health_check_protocol               = "HTTP"
health_check_matcher                = 200
health_check_timeout                = 3
health_check_path                   = "/"
unhealthy_threshold                 = 2

# Redirect all traffic from the ALB to the target group ###############

lb_listerner_port                   = 8080
lb_listerner_protocol               = "HTTP"
lb_listerner_type                   = "forward"                 



#######################  App Auto Scaling (ASG) #####################

ASG_svc_namespace                   = "ecs"
ASG_max_capacity                    = 3
ASG_min_capacity                    = 1
ASG_policy_type                     = "TargetTrackingScaling"

############ CPU Utilization #####################

cpu_policy_name                     = "application-scaling-policy-cpu"
ASG_predefined_metric_type          = "ECSServiceAverageCPUUtilization"

ASG_target_value                    = 80
ASG_scale_out_cooldown              = 120
ASG_scale_in_cooldown               = 120

#############  Memory Utilization ###############

memory_policy_name                  = "application-scaling-policy-memory"
ASG_memory_predefined_metric_type   = "ECSServiceAverageMemoryUtilization"

ASG_memory_target_value             = 80
ASG_memory_scale_out_cooldown       = 120
ASG_memory_scale_in_cooldown        = 120



###############   IAM  #############################

iam_actions                         = "sts:AssumeRole"
principle_type                      = "Service"
principle_identifiers               = "ecs-tasks.amazonaws.com"

policy_arn                          = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"



#################### RDS ############################


allocated_storage = 20
db_name = "homeinspection001"
identifier = "rds-terraform"    
storage_type = "gp2"
engine = "mysql"
availability_zone = "us-east-1a"
engine_version = "8.0.27"
instance_class = "db.t2.medium"
username = "softobiz"
password = "homeinspection"
publicly_accessible    = false
skip_final_snapshot    = true


 

 



















