
/*
output "template" {
  description = "Public ip for the BIGIP, access on port 8443"
  value       = data.template_file.init.rendered
}

output gwlb_frontend_ipconfig_id {
  value = jsondecode(azurerm_resource_group_template_deployment.arm_deployment_gwlb.output_content).agwFrontEndLoadBalancerId.value
}

output gwlb_backend_pool_id {
  value = jsondecode(azurerm_resource_group_template_deployment.arm_deployment_gwlb.output_content).agwBackEndLoadBalancerId.value
}

*/
output "application_url" {
  description = "Public URL to access web app"
  value       = "http://${azurerm_public_ip.public_lb_frontend_ip.ip_address}/"
}

