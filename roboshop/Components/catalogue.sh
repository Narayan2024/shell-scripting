#! /bin/bash

COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m This script is expected to be used by a root user or with a sudo privilege \e[0m]"
    exit 1
fi

stat() {

    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m" 
else
    echo -e "\e[31m Failure \e[0m" 
    exit 2
fi
}

echo -e "************\e[35m Installation has started \e[0m ************"

echo -n "Configuring $COMPONENT repo and Installing Nodejs  :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOGFILE
yum install nodejs -y &>> $LOGFILE
stat $?

id $APPUSER &>> $LOGFILE
if [ $? -ne 0 ] ; then
echo -n "Creating the service account :"
useradd $APPUSER &>> $LOGFILE
stat $?
fi


# echo -n "
# curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
# cd /home/roboshop
# unzip /tmp/catalogue.zip
# mv catalogue-main catalogue
# cd /home/roboshop/catalogue
# npm install
