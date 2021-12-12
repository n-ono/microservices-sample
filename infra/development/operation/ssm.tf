resource "aws_iam_role" "this" {
  name               = "bastion-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.this.json

  tags = {
    Name = "bastion-ssm-role"
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = data.aws_iam_policy.this.arn
}

resource "aws_iam_instance_profile" "this" {
  name = "bastion-ssm-role"
  role = aws_iam_role.this.name

  tags = {
    Name = "bastion-ssm-role"
  }
}
