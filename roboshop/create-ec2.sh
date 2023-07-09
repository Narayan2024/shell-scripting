#!bin/bash

COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'|sed -e 's/"//g')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq '.SecurityGroups[].GroupId'|sed -e 's/"//g')

echo -e "AMI ID used to launch EC2 is \e[32m $AMI_ID \e[0m"
echo -e "Security group ID used to launch EC2 is \e[32m $SG_ID \e[0m"

echo -e " ****** Lauching the server ******* "

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq .







