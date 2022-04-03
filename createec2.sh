#!/bin/bash
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" | jq '.Images[].ImageId')
echo $AMI_ID
aws ec2 run-instances --image-id $(AMI_ID) --instance-type t3.small