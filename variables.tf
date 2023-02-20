################    AWS CREDENTIALS

variable "region" {}
variable "prefix" {}
variable "environment" {}


####################        VPC    

variable "aws_vpc_cidr" {}

variable "enable_dns_support" {
  type = bool
}
variable "enable_dns_hostnames" {
  type = bool
}
variable "instance_tenancy" {
  type = string
}

variable "public_subnet-1_cidr" {}
variable "public_subnet-2_cidr" {}
variable "private_subnet-1_cidr" {}
variable "private_subnet-2_cidr" {}
variable "rt_cidr" {
  description = "cidr block of routing table"
}

variable "public_subnet_availability_zone-1" {}
variable "public_subnet_availability_zone-2" {}
variable "private_subnet_availability_zone-1" {}
variable "private_subnet_availability_zone-2" {}


###########################     Security Group

#>>>>>>>>>  load balancer security group

variable "lb_sg_describe" {}

##  =>  Ingress rule

variable "lb_sg_ingress_describe" {}
variable "lb_sg_ingress_port" {}
variable "lb_sg_ingress_protocol" {}
variable "lb_sg_ingress_ip4_cidr" {}


## => Outgress rule

variable "lb_sg_outgress_describe" {}
variable "lb_sg_outgress_port" {}
variable "lb_sg_outgress_protocol" {}
variable "lb_sg_outgress_ip6_cidr" {}


#>>>>>>>>>   ECS Service security group

variable "svc_sg_describe" {}

##  =>  Ingress rule

variable "svc_sg_ingress_describe" {}
variable "svc_sg_ingress_port" {}
variable "svc_sg_ingress_protocol" {}
#variable "svc_sg_ingress_ip4_cidr" {}


## => Outgress rule

variable "svc_sg_outgress_describe" {}
variable "svc_sg_outgress_port" {}
variable "svc_sg_outgress_protocol" {}
variable "svc_sg_outgress_ip6_cidr" {}


#>>>>>>>>>>>>>>   RDS Security Group

variable "rds_sg_describe" {}

##  =>  Ingress rule

variable "rds_sg_ingress_describe" {}
variable "rds_sg_ingress_port" {}
variable "rds_sg_ingress_protocol" {}
#variable "rds_sg_ingress_ip4_cidr" {}


## => Outgress rule

variable "rds_sg_outgress_describe" {}
variable "rds_sg_outgress_port" {}
variable "rds_sg_outgress_protocol" {}
variable "rds_sg_outgress_ip6_cidr" {}


#######################    ECR

variable ecr_img_tag_mutability {
  type = string
}

variable ecr_img_sacn_on_push {
  type = bool
}

variable ecr_img_name {
  type = string
  description = "name of image which are kept into ecr repo"
}


######################  ECS CLUSTER

variable "containerInsights_name" {
  type = string
}
variable "containerInsights_value" {
  type = string
}


##################  TASK DEFINATION

variable "TD_network_mode" {}
variable "TD_cpu" {}
variable "TD_memory" {}

variable TD_container_defination_essential {
  type = bool
}
variable TD_container_defination_protocol {
  type = string
} 
variable TD_container_defination_containerPort {
  type = number
}
variable TD_container_defination_hostPort {
  type = number
}

variable "soft_limit" {
  type = string
}

variable "retention_in_days" {
  type = number
}


#####################################  ECS SVC

variable "svc_desire_count" {}

variable "force_new_deployment" {
  type = bool  
}

variable "svc_network_assign_ip" {
  type = bool
}

variable "svc_enable_ecs_tags" {
  type = bool
}

#variable "svc_lb_container_name" {}
variable "svc_lb_container_port" {}


###########################  loadbalancer

variable tg_port {
  type = number
}
variable tg_protocol {
  type = string
}
variable tg_target_type {
  type = string
}
variable health_threshold {
  type = number
}
variable health_check_interval {
  type = number
}
variable health_check_protocol {
  type = string
}
variable health_check_matcher {
  type = number
}
variable health_check_timeout {
  type = number
}
variable health_check_path {
  type = string
}
variable unhealthy_threshold {
  type = number
}

# Redirect all traffic from the ALB to the target group

variable lb_listerner_port {
  type = number
}
variable lb_listerner_protocol {
  type = string
}
variable lb_listerner_type {
  type = string
}              


##############################    AUTO SCALING (ASG)

variable "ASG_svc_namespace" {}

variable "ASG_max_capacity" {
  type = number
}

variable "ASG_min_capacity" {
  type = number
}

variable ASG_policy_type {
  type = string
}

#>>>>>>>>>>>  CPU Utilization

variable "cpu_policy_name" {}


variable "ASG_predefined_metric_type" {
  type = string
}

variable "ASG_target_value" {
  type = number
}

variable "ASG_scale_out_cooldown" {
  type = number
}

variable "ASG_scale_in_cooldown" {
  type = number
}

#>>>>>>>>>>>>> Memory Utilization

variable "memory_policy_name" {}

variable "ASG_memory_predefined_metric_type" {
  type = string
}

variable "ASG_memory_target_value" {
  type = number
}

variable "ASG_memory_scale_out_cooldown" {
  type = number
}

variable "ASG_memory_scale_in_cooldown" {
  type = number
}


#####################################  IAM

variable "iam_actions" {}
variable "principle_type" {}
variable "principle_identifiers" {}

variable "policy_arn" {}


#################### RDS ##########################

variable "allocated_storage" {
  type = string
}

variable "db_name" {
  type = string
}

variable "identifier" {
  type = string
}

variable "storage_type" {
  type = string
}

variable "engine" {
  type = string
}

variable "availability_zone" {
  type = string
}
variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}


variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "publicly_accessible" {
  type = string
}

variable "skip_final_snapshot" {
  type = string
}




















