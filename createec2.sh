#!/bin/bash

if [ -z "$1" 0 ]; then
  exit 1
  fi
  COMPONENT=$1
echo "input machine name is needed"
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID
aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.small --tag-specifications "ResourceType=instance,Tags=[{Key=name,Value=${COMPONENT}]"


