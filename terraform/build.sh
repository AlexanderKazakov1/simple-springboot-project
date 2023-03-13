#!/bin/bash
sudo apt update
sudo apt-get install -y openjdk-11-jdk
sudo apt install -y maven
sudo apt install -y awscli
sudo apt install -y git
sudo git clone https://github.com/AlexanderKazakov1/simple-springboot-project.git
cd simple-springboot-project
sudo git checkout feature/terraform
sudo mvn clean install
export AWS_ACCESS_KEY_ID=AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=us-east-1
aws s3 target/app-0.0.1-SNAPSHOT.jar s3://a1kazakov.awshub.com