#!/bin/bash

COMPONENT="user"

source components/common.sh

NODEJS              # calling nodejs function


# sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' /etc/systemd/system/user.service
# systemctl daemon-reload
# systemctl enable user
# systemctl restart user

