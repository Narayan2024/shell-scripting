#!/bin/bash

COMPONENT="user"

source components/common.sh

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

echo -n "Downloading the $COMPONENT component :"
curl -s -L -o /tmp/user.zip "https://github.com/stans-robot-project/user/archive/main.zip"
stat $?

echo -n "Copying the $COMPONENT to $APPUSER home directory :"
cd /home/${APPUSER}/
rm -rf ${COMPONENT} &>> $LOGFILE
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE
stat $?

echo -n "Modifying the Ownership :"
mv $COMPONENT-main/$COMPONENT
chown -R $APPUSER:$APPUSER /home/${APPUSER}/$COMPONENT/ 
stat $?

echo -n "Generating npm $COMPONENT artifacts :"
cd /home/${APPUSER}/${COMPONENT}/ 
npm install &>> $LOGFILE
stat $?

echo -n "Updating the $COMPONENT systemd file : "
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/${APPUSER}/$COMPONENT/systemd.service  &>> $LOGFILE
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>> $LOGFILE
stat $?

echo -n "Starting $COMPONENT service : "
systemctl daemon-reload &>> $LOGFILE
systemctl enable ${COMPONENT} &>> $LOGFILE
systemctl restart ${COMPONENT} &>> $LOGFILE
stat $?


echo -e "************\e[35m Installation has completed \e[0m ************"



