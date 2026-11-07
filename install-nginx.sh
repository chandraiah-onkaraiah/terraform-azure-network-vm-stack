#!/bin/bash

sudo apt-get update -y
sudo apt-get install nginx -y

sudo systemctl enable nginx
sudo systemctl start nginx

echo "<h1>Welcome! Nginx installed using Terraform CSE</h1>" | sudo tee /var/www/html/index.html
