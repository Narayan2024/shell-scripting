#!/bin/bash

COMPONENT=frontend

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m This script is expected to be used by a root user or with a sudo privilege \e[0m]"
    exit 1
fi

echo -n "Installing nginx :"
yum install nginx -y &>> "/tmp/${COMPONENT}.log"

if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m" 
else
    echo -e "\e[32m Failure \e[0m" 
fi

echo -n "Downloading the frontend component"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m" 
else
    echo -e "\e[32m Failure \e[0m" 
fi

echo -n "Performing cleanup"
cd /usr/share/nginx/html
rm -rf * &>> "/tmp/${COMPONENT}.log"

if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m" 
else
    echo -e "\e[32m Failure \e[0m" 
fi


# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

# ```
# # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# ```

# Deploy in Nginx Default Location.
# #! /bin/bash

# The frontend is the service in RobotShop to serve the web content over Nginx.

# Install Nginx.

# ```
# # yum install nginx -y
# # systemctl enable nginx
# # systemctl start nginx

# ```

# Let's download the HTDOCS content and deploy it under the Nginx path.

# ```
# # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# ```

# Deploy in Nginx Default Location.
# #! /bin/bash

# The frontend is the service in RobotShop to serve the web content over Nginx.

# Install Nginx.

# ```
# # yum install nginx -y
# # systemctl enable nginx
# # systemctl start nginx

# ```

# Let's download the HTDOCS content and deploy it under the Nginx path.

# ```
# # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# ```

# Deploy in Nginx Default Location.


# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
