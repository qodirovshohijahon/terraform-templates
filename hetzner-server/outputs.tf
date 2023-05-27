output "server_ip" {
  value = hcloud_server.web.ipv4_address
}

# output "server_ip" {
#   value = terraform.output.server_ip
# }
