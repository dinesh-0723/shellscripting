#!/bin/bash
source components/common.sh


print "setup yum repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
statcheck $?


print "Install Mongodb"
 yum install -y mongodb-org &>>$LOG_FILE
 statcheck $?


print "update mongodb listen address"
sed -i -e '/s/127.0.0.1/0.0.0.0' /etc/mongod.conf
statcheck $?

print "start mongodb"
systemctl enable mongod &>>LOG_FILE && systemctl restart mongod &>>LOG_FILE
statcheck $?





