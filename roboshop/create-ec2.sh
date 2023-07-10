#!bin/bash

COMPONENT=$1
ENV=$2
HOSTEDZONEID=Z018970427MPVGA85AVVY

if [ -z "$1" ] || [ -z "$2" ] ; then
        echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m"
        echo -e "\e[35m Ex usage : \n \t \t bash create-ec2.sh componentName envName\e[0m"
        exit 1
fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'|sed -e 's/"//g')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq '.SecurityGroups[].GroupId'|sed -e 's/"//g')

create-ec2() {

        echo -e "AMI ID used to launch EC2 is \e[32m $AMI_ID \e[0m"
        echo -e "Security group ID used to launch EC2 is \e[32m $SG_ID \e[0m"
        echo -e " \e[35m ****** Launching the server ******* \e[0m"

        IPADDRESS=$(aws ec2 run-instances --image-id ${AMI_ID} --security-group-ids ${SG_ID} --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT-$ENV}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

        echo -e " \e[35m****** Launching the $COMPONENT-$ENV server is completed \e[0m ******* "
        echo -e "Private IPADDRESS of the $COMPONENT-$ENV is \e[35m $IPADDRESS \e[0m"
        echo -e "\e[36m **** Creating DNS record for the $COMPONENT **** \e[0m"

        sed -e "s/COMPONENT/${COMPONENT}-${ENV}/" -e "s/IPADDRESS/${IPADDRESS}/" route53.json > /tmp/record.json
        aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/record.json

        echo -e "\e[36m **** Creating DNS record for the $COMPONENT has completed **** \e[0m"

}

if [ "$1" = "all" ] ; then

    for component in frontend mongodb catalogue redis user cart shipping payment mysql ; do
        COMPONENT=$component
        create-ec2
    done

else

    create-ec2

fi



