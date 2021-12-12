resource "aws_subnet" "public_1a" {
  vpc_id = aws_default_vpc.default.id

  # https://www.terraform.io/docs/language/functions/cidrsubnet.html
  cidr_block        = cidrsubnet(aws_default_vpc.default.cidr_block, 4, 5)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "public-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id = aws_default_vpc.default.id

  # https://www.terraform.io/docs/language/functions/cidrsubnet.html
  cidr_block        = cidrsubnet(aws_default_vpc.default.cidr_block, 4, 6)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "public-1c"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id = aws_default_vpc.default.id

  # https://www.terraform.io/docs/language/functions/cidrsubnet.html
  cidr_block        = cidrsubnet(aws_default_vpc.default.cidr_block, 4, 7)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "private-1a"
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id = aws_default_vpc.default.id

  # https://www.terraform.io/docs/language/functions/cidrsubnet.html
  cidr_block        = cidrsubnet(aws_default_vpc.default.cidr_block, 4, 8)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "private-1c"
  }
}
