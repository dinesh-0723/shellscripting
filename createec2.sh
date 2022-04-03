#!/bin/bash

if [ -z "$1" ]; then
  echo -e "\e[31minput machine name is needed\e[0m"
  exit 1
  fi
  COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID
aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.small --tag-specifications "ResourceType=instance,Tags=[{Key=name,Value=${COMPONENT}}]" | jq


