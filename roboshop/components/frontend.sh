#!/bin/bash
echo -e "\e[36m Installing nginx \e[0m"
yum install nginx -y
echo -e "\e[36m downloading nginx content \e[0m"

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[starting nginx \e[0m"
systemctl restart nginx
systemctl enable nginx