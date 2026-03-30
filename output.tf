output "frontend_url" {
  value = "http://${aws_instance.frontend.public_ip}:9005"
}