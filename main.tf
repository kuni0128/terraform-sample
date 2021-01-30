resource "aws_security_group" "example_ec2" {
  name = "example-ec2"

  ingress = [{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "example_ec2_ingress"
    ipv6_cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
    security_groups = []
    self = false
  }]

  egress = [{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "example_ec2_egress"
    ipv6_cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
    security_groups = []
    self = false
  }]
}

resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.example_ec2.id]
  user_data = file("./user_data.sh")
}

output "example_public_dns" {
  value = aws_instance.example.public_dns
}
