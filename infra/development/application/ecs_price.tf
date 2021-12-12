resource "aws_ecs_task_definition" "price_calculation" {
  family                   = "price-calculation"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = file("./task_definitions/price_calculation.json")
}

resource "aws_ecs_service" "price_calculation" {
  name             = "price-calculation"
  cluster          = aws_ecs_cluster.railway_price_calculation.name
  launch_type      = "FARGATE"
  desired_count    = "2"
  task_definition  = aws_ecs_task_definition.price_calculation.arn
  platform_version = "1.4.0"

  network_configuration {
    subnets         = [data.aws_subnet.private_1a.id, data.aws_subnet.private_1c.id]
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.price_calculation.arn
    container_name   = "price_calculation"
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }
}
