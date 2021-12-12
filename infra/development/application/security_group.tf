resource "aws_security_group" "ecs" {
  name        = "railway-price-calculation-ecs-sg"
  description = "railway price calculation ecs sg"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "railway-price-calculation-ecs-sg"
  }
}
