variable "db_password" {}

resource "aws_db_subnet_group" "catalogue_db" {
  name       = "catalogue-db"
  subnet_ids = [data.aws_subnet.private_1a.id, data.aws_subnet.private_1c.id]

  tags = {
    Name = "catalogue-db"
  }
}

resource "aws_db_instance" "catalogue_db" {
  identifier             = "catalogue-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "13.4"
  instance_class         = "db.t3.micro"
  name                   = "catalogue_db"
  username               = "catalogue"
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.catalogue_db.id]
  db_subnet_group_name   = aws_db_subnet_group.catalogue_db.name
  skip_final_snapshot    = true
}
