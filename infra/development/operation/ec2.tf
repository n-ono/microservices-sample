resource "aws_instance" "bastion" {
  ami                    = data.aws_ssm_parameter.amzn2_ami.value
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = data.aws_subnet.private_1a.id
  iam_instance_profile   = aws_iam_instance_profile.this.name
  user_data              = file("./script/init.sh")

  tags = {
    Name = "bastion"
  }
}

resource "aws_security_group" "bastion" {
  name   = "bastion-sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}
