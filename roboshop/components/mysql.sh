#!/bin/bash

COMPONENT="mysql"

source components/common.sh

echo -n "Configuring the $COMPONENT repository : "
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "Installing $COMPONENT : "
yum install mysql-community-server -y     &>> LOGFILE
stat $?

echo -n "Starting $COMPONENT : "
systemctl enable mysqld &>> LOGFILE
systemctl start mysqld &>> LOGFILE
stat $?

echo -n "Fetching default root password : "
DEFAULT_ROOT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')   &>> LOGFILE
stat $?

# I want this to be executed only if the default password reset was not done
echo "show databases;" | mysql -uroot -pRoboShop@1 &>> LOGFILE
if [ $? -ne 0 ] ; then 
    echo -n "Performing root user password reset :"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PASSWORD}  &>> LOGFILE
    stat $? 
fi

echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password &>> LOGFILE
if [ $? -eq 0 ] ; then 
    echo -n "Uninstalling the validate_password plugin :"
    echo "UNINSTALL PLUGIN validate_password;" | mysql -uroot -pRoboShop@1   &>> LOGFILE
    stat $? 
fi

echo -n "Downloading the $COMPONENT schema:"
curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"   &>> LOGFILE
stat $?

echo -n "Extracting the $COMPONENT schema :"
cd /tmp
unzip -o /tmp/${COMPONENT}.zip    &>> LOGFILE
cd ${COMPONENT}-main
mysql -u root -pRoboShop@1 <shipping.sql    &>> LOGFILE
stat $?

