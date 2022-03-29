#!/bin/bash
source components/common.sh


print "configure yum repos"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>${LOG_FILE}
statcheck $?

print "Install MySQL"
yum install mysql-community-server -y &>>${LOG_FILE}
statcheck $?

print "start mysql"

systemctl enable mysqld &>>${LOG_FILE} && systemctl start mysqld &>>${LOG_FILE}
statcheck $?

