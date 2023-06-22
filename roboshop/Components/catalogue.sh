#! /bin/bash

COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"

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
echo -n "Installing Node.js :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOGFILE
yum install nodejs -y &>> $LOGFILE
stat $?
