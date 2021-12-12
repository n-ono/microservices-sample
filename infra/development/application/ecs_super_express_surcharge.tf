resource "aws_ecs_task_definition" "super_express_surcharge_calculation" {
  family                   = "super-express-surcharge-calculation"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = file("./task_definitions/super_express_surcharge_calculation.json")
}

resource "aws_ecs_service" "super_express_surcharge_calculation" {
  name             = "super-express-surcharge-calculation"
  cluster          = aws_ecs_cluster.railway_price_calculation.name
  launch_type      = "FARGATE"
  desired_count    = "2"
  task_definition  = aws_ecs_task_definition.super_express_surcharge_calculation.arn
  platform_version = "1.4.0"

  network_configuration {
    subnets         = [data.aws_subnet.private_1a.id, data.aws_subnet.private_1c.id]
    security_groups = [aws_security_group.ecs.id]
  }

  service_registries {
    registry_arn = aws_service_discovery_service.super_express_surcharge_calculation_api.arn
  }

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }
}
