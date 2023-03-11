terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "ssh" {
  key_name   = "ssh"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxmiPMAbhfWQChiDymXGzMuvqFRUDtVbRbGNZK9PpzN7H5cBw/+fK5BsaZiE7JdJC6Iq9rDz5Y4L3IVBMPWgfOWrSqzoNKD//DVdr9zxk5pR2UUZnRKYlONYhXYIxSUXi8pmW7IVOdmX18PgLY3MQRtV1rYglM+7+iBtS4P+QaG62Xyrx8FkI8i1XmWwGGXLY++IcIiV2SGrFEb9g2rf7uYiI0+qxU/EkyyqkWQEJmcu63n6P4W/P8ZmplkFpxJt3nmKPfkFohcr7U5YZCSS9lmEvILneTuHb00BHUUR9+fwa60h69weFfmSWLLykAwbkYZXLCCN66NUQrmoT2p79hhVNgNxcQMIKMG0GXsJzDsQ1FutQ8d0HANY/KfqZpp6t4HNchKRfbaF8W9zTVDF8HE8yX/jt8L7yea+Yu7mT57Inz2J7ymVYLZ96DLXi+e8VDEGIh//smadtDoIuaG9BzO0OCC16EtJnPwb+eveCjzWavKu0FoTCuodosWZ4yKpE= user@ubuntu-20-4-13-aws"
}

resource "aws_security_group" "allow_app_traffic" {
  name        = "allow_traffic"
  vpc_id      = "vpc-07e7e98ef52a45795"

  ingress {
    description = "app from anywhere"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["158.160.57.17/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

//input credentials in sh
resource "aws_instance" "build" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  subnet_id = "subnet-097cf36c35f891602"
  key_name = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [ aws_security_group.allow_app_traffic.id ]
  user_data = file("build.sh")

  tags = {
    name = "build"
  }
}

//input credentials in sh
resource "aws_instance" "deploy" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  subnet_id = "subnet-097cf36c35f891602"
  key_name = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [ aws_security_group.allow_app_traffic.id ]
  user_data = file("deploy.sh")

tags = {
    name = "deploy"
  }
}