#!/bin/bash

COMPONENT=cart

source components/common.sh

NODEJS              # calling nodejs function

# unzip -o /tmp/cart.zip
# mv cart-main/ cart
# chown -R roboshop:roboshop /home/roboshop/cart/
# cd cart
# npm install (npm was not installe properly)

# mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
# sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/'  /etc/systemd/system/cart.service
# systemctl daemon-reload
# systemctl enable cart
# systemctl restart cart