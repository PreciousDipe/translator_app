// Generate private key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits = 4096
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS"
  default     = "uniquepolly.pem"
}

// Create a new key pair for connecting to the EC2 instance via ssh
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

// Save PEM file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name

  provisioner "local-exec" {
    command = "chmod 400 ${var.key_name}"
  }
}

// Create a security group
resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  description = "Security group for EC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Create EC2 instance
resource "aws_instance" "public_instance" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]

  tags = {
    Name = "Linux Server"
  }

  /* provisioner "file" {
    source      = "./deploy-app.yml"  # Path to your Ansible playbook
    destination = "/home/ubuntu/deploy-app.yml"  # Where the playbook will be stored on the instance

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.rsa_4096.private_key_pem
    }
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Setting up Ansible configuration on EC2 instance' > setup.txt",
      "sudo apt-get update -y",
      "sudo apt-get install -y ansible",
      "echo '[localhost]' > /home/ubuntu/hosts",
      "echo 'localhost ansible_connection=local' >> /home/ubuntu/hosts",
      "sudo ansible-playbook -i /home/ubuntu/hosts /home/ubuntu/deploy-app.yml"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.rsa_4096.private_key_pem
    }
  }
  */
}

// Outputs
output "instance_ip" {
  value = aws_instance.public_instance.public_ip
}

output "instance_user" {
  value = "ubuntu"  # Assuming the AMI uses 'ubuntu' as the default user
}

output "private_key_pem" {
  value     = tls_private_key.rsa_4096.private_key_pem
  sensitive = true
}