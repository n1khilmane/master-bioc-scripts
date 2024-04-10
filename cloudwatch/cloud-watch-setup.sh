
#!/bin/bash

#Update Your System
sudo apt-get update && sudo apt-get upgrade -y

#Install the CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

#Use the Wizard for Configuration
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard

#need to match cloudwatch agent config file in /opt/aws/amazon-cloudwatch-agent/bin/config.json in master
