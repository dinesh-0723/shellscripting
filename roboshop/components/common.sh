
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