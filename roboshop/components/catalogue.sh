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

echo -n "Downloading the $COMPONENT component :"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "Copying the $COMPONENT to $APPUSER home directory :"
cd /home/${APPUSER}
rm -rf ${COMPONENT} &>> $LOGFILE
unzip -o /tmp/catalogue.zip &>> $LOGFILE
stat $?

echo -n "Modifying the Ownership :"
mv $COMPONENT-main/ $COMPONENT
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT/ 
stat $?

echo -n "Generating npm $COMPONENT artifacts :"
cd /home/${APPUSER}/${COMPONENT}/
npm install &>> $LOGFILE
stat $?

echo -n "Updating the $COMPONENT systemd file :"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/${APPUSER}/$COMPONENT systemd.service
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting ${COMPONENT} service : "
systemctl daemon-reload &>> $LOGFILE
systemctl enable catalogue &>> $LOGFILE
systemctl restart catalogue &>> $LOGFILE
stat $?


echo -e "************\e[35m Installation has completed \e[0m ************"



# **NOTE:** You should see the log saying `connected to MongoDB`, then only your catalogue
# will work and can fetch the items from MongoDB

# **Ref Log:**
# {"level":"info","time":1656660782066,"pid":12217,"hostname":"ip-172-31-13-123.ec2.internal","msg":**"MongoDB connected",**"v":1}
# ```

# 1. Now, you would still see **`CATEGORIES`** on the frontend page as emp





