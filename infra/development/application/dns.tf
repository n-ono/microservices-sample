# 運賃計算サービス用 Service Discovery
resource "aws_service_discovery_private_dns_namespace" "fare_calculation" {
  name        = "fare.internal"
  description = "fare calculation service discovery"
  vpc         = aws_default_vpc.default.id
}

resource "aws_service_discovery_service" "fare_calculation_api" {
  name = "fare-api"

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.fare_calculation.id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

# 特急料金計算サービス用 Service Discovery
resource "aws_service_discovery_private_dns_namespace" "super_express_surcharge_calculation" {
  name        = "super-express-surcharge.internal"
  description = "super express surcharge calculation service discovery"
  vpc         = aws_default_vpc.default.id
}

resource "aws_service_discovery_service" "super_express_surcharge_calculation_api" {
  name = "super-express-surcharge-api"

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.super_express_surcharge_calculation.id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

# 割引計算サービス用 Service Discovery
resource "aws_service_discovery_private_dns_namespace" "discount_calculation" {
  name        = "discount.internal"
  description = "discount calculation service discovery"
  vpc         = aws_default_vpc.default.id
}

resource "aws_service_discovery_service" "discount_calculation_api" {
  name = "discount-api"

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.discount_calculation.id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

# カタログ用 Service Discovery
resource "aws_service_discovery_private_dns_namespace" "catalogue" {
  name        = "catalogue.internal"
  description = "catalogue service discovery"
  vpc         = aws_default_vpc.default.id
}

resource "aws_service_discovery_service" "catalogue_api" {
  name = "catalogue-api"

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.catalogue.id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
