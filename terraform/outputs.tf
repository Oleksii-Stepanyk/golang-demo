output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.task.id
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.main-db.endpoint
}