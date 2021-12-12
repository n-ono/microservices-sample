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
