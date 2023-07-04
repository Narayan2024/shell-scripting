#!/bin/bash

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

CREATE_USER (){
    id $APPUSER &>> $LOGFILE
if [ $? -ne 0 ] ; then
echo -n "Creating the service account :"
useradd $APPUSER &>> $LOGFILE
stat $?
fi
}

DOWNLOAD_AND_EXTRACT () {

    echo -n "Downloading the $COMPONENT component :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Copying the $COMPONENT to $APPUSER home directory :"
cd /home/${APPUSER}
rm -rf ${COMPONENT}         &>> $LOGFILE
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE
stat $?

echo -n "Modifying the Ownership :"
mv $COMPONENT-main/ $COMPONENT
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT/
stat $?
}

NPM_INSTALL() {
        echo -n "Generating npm $COMPONENT artifacts :"
cd /home/${APPUSER}/${COMPONENT}/
npm install &>> $LOGFILE
stat $?

}

CONFIGURE_SVC () {

    echo -n "Updating the $COMPONENT systemd file :"
sed -i -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service  &>> $LOGFILE
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>> $LOGFILE
stat $?

echo -n "Starting ${COMPONENT} service : "
systemctl daemon-reload &>> $LOGFILE
systemctl enable $COMPONENT &>> $LOGFILE
systemctl restart $COMPONENT &>> $LOGFILE
stat $?

}

NODEJS() {
    echo -e "************\e[35m Installation has started \e[0m ************"

echo -n "Configuring $COMPONENT repo and Installing Nodejs  :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOGFILE
stat $?

echo -n "Installing Nodejs  :"
yum install nodejs -y &>> $LOGFILE
stat $?
    
CREATE_USER             # calling Create_user function to create the roboshop user account

DOWNLOAD_AND_EXTRACT    # calling DOWNLOAD_AND_EXTRACT function to download the content

NPM_INSTALL             # Creates artifacts

CONFIGURE_SVC           # Configuring the service

}

MVN_PACKAGE() {
    echo -n "Preparing $COMPONENT artifacts : "
    cd /home/${APPUSER}/${COMPONENT}  &>> $LOGFILE
    mvn clean package    &>> $LOGFILE
    mv target/shipping-1.0.jar shipping.jar  &>> $LOGFILE
    stat $?
}

JAVA() {
    echo -n "Installing Maven : "
    yum install maven -y     &>> $LOGFILE
    stat $?

CREATE_USER             # calling Create_user function to create the roboshop user account

DOWNLOAD_AND_EXTRACT    # calling DOWNLOAD_AND_EXTRACT function to download the content

MVN_PACKAGE             # calling maven package

CONFIGURE_SVC

}