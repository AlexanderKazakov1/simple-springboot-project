#!/bin/bash
sudo apt update && sudo apt install -y openjdk-8-jdk maven awscli git
# shellcheck disable=SC2164
cd /home/ubuntu
aws s3 cp s3://a1kazakov.awshub.com/app-0.0.1-SNAPSHOT.jar /home/ubuntu/app/app-0.0.1-SNAPSHOT.jar
java -jar app-0.0.1-SNAPSHOT.jar