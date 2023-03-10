#!/bin/bash
sudo apt update && sudo apt install -y openjdk-8-jdk maven awscli git
# shellcheck disable=SC2164
cd /home/ubuntu
git clone https://github.com/AlexanderKazakov1/simple-springboot-project.git
# shellcheck disable=SC2164
cd /simple-springboot-project
git checkout feature/terraform
mvn clean install
aws s3 target/app-0.0.1-SNAPSHOT.jar s3://a1kazakov.awshub.com