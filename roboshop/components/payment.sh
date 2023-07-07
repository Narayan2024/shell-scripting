#!/bin/bash

COMPONENT="payment"

source components/common.sh

PYTHON     #calling python function


# sed -i -e "/^uid/ c uid=id -u roboshop" -e "/^gid/ c gid=id -g roboshop"  home/roboshop/payment/payment.ini