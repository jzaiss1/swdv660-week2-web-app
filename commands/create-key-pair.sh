#!/bin/bash

# Create: 
aws ec2 create-key-pair --key-name $1 --query 'KeyMaterial' --output text > ~/.ssh/$1.pem

# Verify:
aws ec2 describe-key-pairs --key-name $1

# View:
cat ~/.ssh/$1.pem

# Secure:
chmod 400 ~/.ssh/$1.pem