#!bin/bash

# aws ec2 run-instances --image-id ami-0abcdef1234567890 --instance-type t2.micro
# aws ec2 describe-images --region us-east-1 --image-ids ami-1234567890EXAMPLE

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId') | sed e 's/ "//g'
echo "AMI ID is $AMI_ID "

