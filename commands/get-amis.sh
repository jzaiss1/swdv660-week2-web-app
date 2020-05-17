#!/bin/bash

aws ec2 describe-images --output table --filters "Name = description, Values = Amazon Linux AMI * x86_64 HVM GP2" --query 'Images[].[ CreationDate, Description, ImageId]'