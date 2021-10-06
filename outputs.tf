
/*
output "template" {
  description = "Public ip for the BIGIP, access on port 8443"
  value       = data.template_file.init.rendered
}
*/
output "application_url" {
  description = "Public URL to access web app"
  value       = "http://${azurerm_public_ip.public_lb_frontend_ip.ip_address}/"
}
