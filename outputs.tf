output "application_url" {
  description = "Public URL to access web app"
  value       = "http://${azurerm_public_ip.public_lb_frontend_ip.ip_address}/"
}
output "ssh_address" {
  description = "SSH to app server"
  value       = "ssh azureuser@${azurerm_public_ip.public_lb_frontend_ip.ip_address}"
}
output "bigip_mgmt_username" {
  description = "username for bigip mgmt console"
  value       = "quickstart"
}

output "bigip_password" {
  description = "password for bigip mgmt console"
  value       = var.upassword
}