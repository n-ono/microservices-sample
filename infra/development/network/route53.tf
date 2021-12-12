resource "aws_route53_record" "railway_pricing" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = data.aws_route53_zone.this.name
  type    = "A"

  alias {
    name                   = aws_lb.price_calculation.dns_name
    zone_id                = aws_lb.price_calculation.zone_id
    evaluate_target_health = true
  }
}
