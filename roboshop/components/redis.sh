#! /bin/bash

COMPONENT=redis

source components/common.sh 

echo -e "************\e[35m Installation has started \e[0m ************"

echo -n "Configuring the repo :"
curl -L https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo -o /etc/yum.repos.d/${COMPONENT}.repo &>> $LOGFILE
stat $?

echo -n "Installing ${COMPONENT} :"
yum install -y ${COMPONENT}-6.2.11  &>> $LOGFILE
stat $?

echo -n "Enabling the DB visibility"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/${COMPONENT}.conf
stat $?

echo -n "Starting ${COMPONENT} :"
systemctl enable ${COMPONENT} &>> $LOGFILE
systemctl start ${COMPONENT} &>> $LOGFILE
stat $?

echo -e "************\e[35m Installation has completed \e[0m ************"




