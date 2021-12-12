resource "aws_s3_bucket" "server_access_logs" {
  bucket = "dev-railway-price-calculation-service-access-logs"
  acl    = "log-delivery-write"
  policy = file("./json/policy.json")

  # 開発系ではログを保持する必要はないため削除保護の対象外
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
