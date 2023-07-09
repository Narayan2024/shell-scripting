#!bin/bash

COMPONENT=$1

if [ -z $1 ] ; then
        echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m"
        echo -e "\e[35m Ex usage : bash create-ec2.sh \e[0m"
fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'|sed -e 's/"//g')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq '.SecurityGroups[].GroupId'|sed -e 's/"//g')

echo -e "AMI ID used to launch EC2 is \e[32m $AMI_ID \e[0m"
echo -e "Security group ID used to launch EC2 is \e[32m $SG_ID \e[0m"

echo -e " ****** Lauching the server ******* "

IPADDRESS=$(aws ec2 run-instances --image-id ${AMI_ID} --security-group-ids ${SG_ID} --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

echo -e "Private IPADDRESS of the $COMPONENT is \e[35m $IPADDRESS \e[0m"






