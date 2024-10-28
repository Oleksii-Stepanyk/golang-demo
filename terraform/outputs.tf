output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.main-db.endpoint
}

output "lb_ip" {
  description = "The IP of the Load Balancer"
  value = aws_lb.golang_alb.dns_name
}