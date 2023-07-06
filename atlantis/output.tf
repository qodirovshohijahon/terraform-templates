#-------------------------
# Output Sections

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "instances_ids" {
  value = [
    aws_instance.jenkins.id
  ]
}

output "securitygroup_id" {
  value = aws_security_group.jenkins-sg.id
}

output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}