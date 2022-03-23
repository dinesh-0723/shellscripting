#!/bin/bash
statcheck() {
  if [ $1 -eq 0 ];then
    echo -e "\e[32m success \e[0m"
    else
      echo -e "\e[31m failure \e[0m"
     exit 2
  fi
}
print() {
  echo -e "\e[36m $1 \e[0m"
}

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ];then
  echo "you should run your script as root user"
  exit 1
fi
print "Installing nginx"
yum install nginx -y
statcheck $?

print "downloading nginx content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
statcheck $?

print "cleaning nginx content"
rm -rf /usr/share/nginx/html/*
statcheck $?

cd /usr/share/nginx/html/

print "extracting archive"
unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* .
statcheck $?

print "update roboshop configuration"
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
statcheck $?

print "starting nginx"
systemctl restart nginx && systemctl enable nginx
statcheck $?

