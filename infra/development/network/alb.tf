resource "aws_lb" "price_calculation" {
  name               = "price-calculation-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [aws_subnet.public_1a.id, aws_subnet.public_1c.id]

  # 開発系では試行錯誤 ( 作り直し ) が発生する想定のため削除保護の対象外
  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.server_access_logs.bucket
    enabled = true
  }
}

resource "aws_lb_target_group" "price_calculation" {
  name        = "price-calculation-tg"
  vpc_id      = aws_default_vpc.default.id
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    timeout             = 10
    interval            = 15
    healthy_threshold   = 3
    unhealthy_threshold = 3
    protocol            = "HTTP"
    port                = 8080
    path                = "/price_calculation/health"
  }
}

resource "aws_lb_listener" "price_calculation" {
  load_balancer_arn = aws_lb.price_calculation.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.price_calculation.arn
  }
}
