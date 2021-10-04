output "template" {
  description = "Public ip for the BIGIP, access on port 8443"
  value       = data.template_file.init.rendered
}
