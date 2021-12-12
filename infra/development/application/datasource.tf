data "aws_subnet" "private_1a" {
  vpc_id = aws_default_vpc.default.id
  filter {
    name   = "tag:Name"
    values = ["private-1a"]
  }
}

data "aws_subnet" "private_1c" {
  vpc_id = aws_default_vpc.default.id
  filter {
    name   = "tag:Name"
    values = ["private-1c"]
  }
}

data "aws_lb_target_group" "price_calculation" {
  name = "price-calculation-tg"
}

data "aws_secretsmanager_secret" "database_username" {
  name = "database-username"
}

data "aws_secretsmanager_secret" "database_password" {
  name = "database-password"
}

data "aws_secretsmanager_secret" "database_endpoint" {
  name = "database-endpoint"
}

data "template_file" "task_template_secretsmanager" {
  template = file("./task_definitions/catalogue.json.tpl")

  vars = {
    database_username = data.aws_secretsmanager_secret.database_username.arn
    database_password = data.aws_secretsmanager_secret.database_password.arn
    database_endpoint = data.aws_secretsmanager_secret.database_endpoint.arn
  }
}
