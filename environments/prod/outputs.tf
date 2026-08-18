output "website_url" {
  value       = "http://${module.loadbalancer.lb_public_ip}"
  description = "The URL to access the web farm"
}