#Creation Unique Deployment Name
locals {
  deployment_id = lower("${var.project_name}-${random_string.suffix.result}")
}

#Generate Ramdom Name with total length "8" eg. a1s2d3f4
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#Generate key using RSA type
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

#Register the public key in AWS
resource "aws_key_pair" "public_key" {
  key_name   = "${local.deployment_id}-key"   
  public_key = tls_private_key.ssh.public_key_openssh  #public_key_openssh is the output of "tls_private_key" 
}

#Save the private key to local machine
resource "local_file" "private_key" {
  content  = tls_private_key.ssh.private_key_openssh #private_key_openssh is the output of "tls_private_key" 
  filename = "${path.root}/private_keys/${local.deployment_id}-key.pem" #Location to save private key

#Changing the file permission
  provisioner "local-exec" {
    command = "chmod 400 ${path.root}/private_keys/${local.deployment_id}-key.pem"
  }
}