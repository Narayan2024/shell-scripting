#!bin/bash

# aws ec2 describe-images --region us-east-1 --image-ids ami-1234567890EXAMPLE

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'|sed -e 's/"//g')

echo -n "AMI ID used to launch EC2 $AMI_ID"

echo -e " ****** Lauching the server ******* "
aws ec2 run-instances --image-id ${AMI_ID} --instance-type t2.micro



