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
  echo -e "\n.......$1.............." &>>$LOG_FILE
  echo -e "\e[36m $1 \e[0m"
}

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ];then
  echo "you should run your script as root user"
  exit 1
fi
LOG_FILE=/tmp/roboshop.log
rm -rf $LOG_FILE

print "Setup MongoDB"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>LOG_FILE
statcheck $?

print "Install Mongodb"
yum install -y mongodb-org &>>LOG_FILE
statcheck $?


print "update mongodb listen address"
sed -i -e 's/127.0.0.1/0.0.0.0./' /etc/mongod.conf
statcheck $?


print "start mongodb"
systemctl enable mongod &>>LOG_FILE && systemctl restart mongod &>>LOG_FILE
statcheck $?
