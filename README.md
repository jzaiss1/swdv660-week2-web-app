# Week 2 | Assignment: Modify and Build a Web Application 

## Notes

### List AMI's

`aws ec2 describe-images --output table --filters "Name = description, Values = Amazon Linux AMI * x86_64 HVM GP2" --query 'Images[].[ CreationDate, Description, ImageId]'`

Use AMI `ami-cfe4b2b0`

### Find VPC

Get VPC `aws ec2 describe-vpcs` and use `vpc-fc312086`

### Create the security group

`aws ec2 create-security-group --group-name HelloWorld --description "Hello World Demo" --vpc-id vpc-fc312086`

Group ID `sg-0ffb278890f6e3c0c`

### Create Firewall Rules

ssh port 22 `aws ec2 authorize-security-group-ingress --group-name HelloWorld --protocol tcp --port 22 --cidr 0.0.0.0/0`

app port 3333 `aws ec2 authorize-security-group-ingress --group-name HelloWorld --protocol tcp --port 3333 --cidr 0.0.0.0/0`

Verify the Security groups

`aws ec2 describe-security-groups --group-names HelloWorld --output text`

### Create the SSH Key Pair

Create: `aws ec2 create-key-pair --key-name EffectiveDevOpsAWS --query 'KeyMaterial' --output text > ~/.ssh/EffectiveDevOpsAWS.pem`

Verify: `aws ec2 describe-key-pairs --key-name EffectiveDevOpsAWS`

View: `cat ~/.ssh/EffectiveDevOpsAWS.pem`

Secure: `chmod 400 ~/.ssh/EffectiveDevOpsAWS.pem`

### Create the EC2 Instance

`aws ec2 run-instances --instance-type t2.micro --key-name EffectiveDevOpsAWS --security-group-ids sg-0ffb278890f6e3c0c --image-id ami-cfe4b2b0`

Instance ID `i-082b94dd8837dceae`

Public IP `34.226.153.53`

DNS Name `ec2-34-226-153-53.compute-1.amazonaws.com`

### SSH to the host

`ssh -i ~/.ssh/EffectiveDevOpsAWS.pem ec2-user@ec2-34-226-153-53.compute-1.amazonaws.com`

Update packages per on screen instructions

### Install Node.js

`sudo yum install --enablerepo=epel -y nodejs`

### Install the web app

Pull from the author's web site

`wget https://raw.githubusercontent.com/yogeshraheja/Effective-DevOps-with-AWS/master/Chapter02/helloworld.js -O /home/ec2-user/helloworld.js`

or better yet get it from this repo!

`wget https://raw.githubusercontent.com/jzaiss1/swdv660-week2-web-app/master/app/helloworld.js -O /home/ec2-user/helloworld.js`

Start the server `node helloworld.js`

### Create as a service

Pull the config file 

`sudo wget https://raw.githubusercontent.com/jzaiss1/swdv660-week2-web-app/master/app/helloworld.conf -O /etc/init/helloworld.conf`