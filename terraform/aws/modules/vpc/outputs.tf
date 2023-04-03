output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "environment" {
  value = var.environment
}
