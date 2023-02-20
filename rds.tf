resource "aws_db_instance" "rds_instance" {
allocated_storage = var.allocated_storage
identifier = "${var.prefix}-${var.environment}-db-001"
storage_type = var.storage_type
db_name = var.db_name
engine = var.engine
engine_version = var.engine_version
availability_zone = var.availability_zone
instance_class = var.instance_class
username = var.username
password = var.password
publicly_accessible    = false
skip_final_snapshot    = true
db_subnet_group_name        = aws_db_subnet_group.db_subnet.id
vpc_security_group_ids      = [aws_security_group.rds-sg.id]

}
