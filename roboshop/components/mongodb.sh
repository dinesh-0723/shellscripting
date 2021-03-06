#!/bin/bash
source components/common.sh

print "Setup MongoDB"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
statcheck $?

print "Install Mongodb"
yum install -y mongodb-org &>>$LOG_FILE
statcheck $?


print "update mongodb listen address"
sed -i -e 's/127.0.0.1/0.0.0.0./' /etc/mongod.conf
statcheck $?


print "start mongodb"
systemctl enable mongod &>>$LOG_FILE && systemctl restart mongod &>>$LOG_FILE
statcheck $?

print "download schema"
curl -f -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG_FILE
statcheck $?

print "extract schema"
cd /tmp &>>$LOG_FILE && unzip -o mongodb.zip &>>$LOG_FILE
statcheck $?

print "load schema"
cd mongodb-main
for schema in catalogue users; do
  echo "load $schema schema"
 mongo < ${schema}.js &>>$LOG_FILE
statcheck $?
done

