resource "aws_security_group" "default_sg" {
  name        = "Server security group"
  description = "Default group for EC2 servers"

  dynamic "ingress" {
    for_each = var.default_server_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
