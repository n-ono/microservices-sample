resource "aws_secretsmanager_secret" "database_username" {
  name        = "database-username"
  description = "rds user name"

  # 開発系では試行錯誤 ( 作り直し ) が発生する想定のため削除保護の対象外
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "database_password" {
  name        = "database-password"
  description = "rds user password"

  # 開発系では試行錯誤 ( 作り直し ) が発生する想定のため削除保護の対象外
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "database_endpoint" {
  name        = "database-endpoint"
  description = "rds endpoint"

  # 開発系では試行錯誤 ( 作り直し ) が発生する想定のため削除保護の対象外
  recovery_window_in_days = 0
}
