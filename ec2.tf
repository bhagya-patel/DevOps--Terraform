#key pair (login)
resource "aws_key_pair" "bhagya_key" {
    key_name   = "bhagya-ec2-key"
    public_key = file("terra-ec2-key.pub")

}

#VPC & security group
resource "aws_default_vpc" "bhagya_default" {
  
}
resource "aws_security_group" "bhagya_security_group" {
    name = "bhagya-automate-sg"
    description = "this will add TF generated Security group"
    vpc_id = aws_default_vpc.bhagya_default.id     #interpolation

    #inbound rules
    ingress {
        protocol  = "tcp"
        from_port = 22
        to_port   = 22
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }
    ingress {
        protocol  = "tcp"
        from_port = 80
        to_port   = 80
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }
    ingress {
        protocol  = "tcp"
        from_port = 8000
        to_port   = 8000
        cidr_blocks = ["0.0.0.0/0"]
        description = "Flask app"
    }


    #outbound rules
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "all access open outbound"
    }

    tags = {
        Name = "bhagya-automate-sg"
    }
}

#ec2 instance

resource "aws_instance" "bhagya_instance" {
    key_name = aws_key_pair.bhagya_key.key_name
    security_groups = [aws_security_group.bhagya_security_group.name]
    instance_type = "t2.micro"
    ami = "ami-020cba7c55df1f615"   #ubuntu

    root_block_device {
      volume_size = 15
      volume_type = "gp3"
    }
    tags = {
        Name = "Bhagya-automate"
    }

}