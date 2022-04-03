#!/bin/bash
AMI ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" | jq '.Images[].ImageId')
echo $AMI ID
