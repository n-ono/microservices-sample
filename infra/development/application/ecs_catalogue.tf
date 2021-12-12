resource "aws_ecs_task_definition" "catalogue" {
  family                   = "catalogue"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = data.template_file.task_template_secretsmanager.rendered
}

resource "aws_ecs_service" "catalogue" {
  name             = "catalogue"
  cluster          = aws_ecs_cluster.railway_price_calculation.name
  launch_type      = "FARGATE"
  desired_count    = "2"
  task_definition  = aws_ecs_task_definition.catalogue.arn
  platform_version = "1.4.0"

  network_configuration {
    subnets         = [data.aws_subnet.private_1a.id, data.aws_subnet.private_1c.id]
    security_groups = [aws_security_group.ecs.id]
  }

  service_registries {
    registry_arn = aws_service_discovery_service.catalogue_api.arn
  }

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }
}
