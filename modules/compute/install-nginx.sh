#!/bin/bash
# Update package lists
sudo apt-get update -y

# Install NGINX
sudo apt-get install nginx -y

# Start the NGINX service
sudo systemctl start nginx

# Enable NGINX to start automatically on system boot
sudo systemctl enable nginx

# Optional: Allow HTTP traffic through the firewall
sudo ufw allow 'Nginx HTTP'