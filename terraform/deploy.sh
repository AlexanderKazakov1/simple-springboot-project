#!/bin/bash
sudo apt update
sudo apt-get install -y openjdk-11-jdk
sudo apt install -y maven
sudo apt install -y awscli
sudo apt install -y git
cd /home/ubuntu
export AWS_ACCESS_KEY_ID=AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=AWS_ACCESS_KEY_ID
export AWS_DEFAULT_REGION=us-east-1
aws s3 cp s3://a1kazakov.awshub.com/app-0.0.1-SNAPSHOT.jar /home/ubuntu/app-0.0.1-SNAPSHOT.jar
java -jar app-0.0.1-SNAPSHOT.jar