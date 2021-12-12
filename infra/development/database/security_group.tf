resource "aws_security_group" "catalogue_db" {
  name   = "catalogue-db-sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.private_1a.cidr_block, data.aws_subnet.private_1c.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "catalogue-db-sg"
  }
}
