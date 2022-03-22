#!/bin/bash
statcheck() {
  if [ $1 -eq 0 ];then
    echo -e "\e[32m success \e[0m"
    else
      echo -e "\e[31m failure \e[0m"
     exit 2
  fi
}

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ];then
  echo "you should run your script as root user"
  exit 1
fi
echo -e "\e[36m Installing nginx \e[0m"
yum install nginx -y
statcheck $?
echo -e "\e[36m downloading nginx content \e[0m"

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[36m starting nginx \e[0m"
systemctl restart nginx
systemctl enable nginx