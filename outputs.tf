output "ec2_public_ip" {
  description = "Public IPv4 address of the EC2 web server."
  value       = aws_instance.web.public_ip
}

output "rds_endpoint" {
  description = "Connection endpoint for the private RDS instance."
  value       = aws_db_instance.main.endpoint
}
