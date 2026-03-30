resource "aws_instance" "backend" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.backend.id]
  key_name               = aws_key_pair.public_key.key_name

  user_data                   = file("${path.module}/user_data/counting.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "${var.project_name}-${var.environment}-backend"
  }
}

resource "aws_instance" "frontend" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.frontend.id]
  key_name               = aws_key_pair.public_key.key_name

  user_data = templatefile("${path.module}/user_data/dashboard.sh", {
    counting_private_ip = aws_instance.backend.private_ip
  })

  tags = {
    Name = "${var.project_name}-${var.environment}-frontend"
  }
}