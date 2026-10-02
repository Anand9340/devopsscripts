#!/bin/bash

set -e

echo "=============================="
echo " Jenkins WAR Auto Setup Script"
echo "=============================="

# Update system
sudo apt update -y

# Install Java 21, wget, curl
sudo apt install -y openjdk-21-jdk wget curl

# Verify Java
java -version

# Create Jenkins directory
sudo mkdir -p /opt/jenkins
cd /opt/jenkins

# Download Jenkins WAR
if [ ! -f jenkins.war ]; then
  echo "Downloading Jenkins WAR..."
  wget https://get.jenkins.io/war/2.552/jenkins.war
else
  echo "Jenkins WAR already exists"
fi

# Permissions
sudo chmod 755 jenkins.war

# Run Jenkins in background
echo "Starting Jenkins in background..."
nohup java -Djava.net.preferIPv4Stack=true -jar /opt/jenkins/jenkins.war \
> /opt/jenkins/jenkins.log 2>&1 &

sleep 5

# Show status
echo "Jenkins process:"
ps -ef | grep jenkins.war | grep -v grep

echo "=============================="
echo " Jenkins started successfully "
echo " URL: http://<SERVER-IP>:8080"
echo " Log: /opt/jenkins/jenkins.log"
echo "=============================="
