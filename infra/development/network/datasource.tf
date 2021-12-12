variable "domain_name" {}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

data "aws_acm_certificate" "issued" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}

data "aws_route53_zone" "this" {
  name = var.domain_name
}
