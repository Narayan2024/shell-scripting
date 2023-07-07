#!/bin/bash

COMPONENT="frontend"

source components/common.sh

echo -e "************\e[35m Installation has started \e[0m ************"

echo -n "Installing nginx :"
yum install nginx -y &>> $LOGFILE
stat $?

echo -n "Downloading the frontend component"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "Performing cleanup"
cd /usr/share/nginx/html
rm -rf * &>> $LOGFILE
stat $?

echo -n "Extracting ${COMPONENT} component :"
unzip /tmp/${COMPONENT}.zip &>> $LOGFILE
mv frontend-main/* . &>> $LOGFILE
mv static/* . &>> $LOGFILE
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?
 
echo -n "Updating the backend component reverse proxy details : "
for component in catalogue user cart shipping payment; do
    sed -i -e "/$component/s/localhost/$component.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
done
stat $?

echo -n "Starting ${COMPONENT} service :"
systemctl daemon-reload &>> $LOGFILE
systemctl enable nginx  &>> $LOGFILE
systemctl restart nginx &>> $LOGFILE
stat $?

echo -e "************\e[35m Installation has completed \e[0m ************"

# sudo sed -i -e "/user/s/localhost/user.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
# sudo sed -i -e "/cart/s/localhost/cart.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
