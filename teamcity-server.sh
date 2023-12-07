#!/bin/bash

cd /
sudo mkdir /srv

# install server dependencies
sudo apt-get update
sudo apt-get install -y openjdk-7-jre-headless
sudo apt-get install -y curl

# install team city
sudo wget -c https://download.jetbrains.com/teamcity/TeamCity-2023.11.tar.gz -O /tmp/TeamCity-2023.11.tar.gz
sudo tar -xvf /tmp/TeamCity-2023.11.tar.gz -C /srv
sudo rm -rf /tmp/TeamCity-2023.11.tar.gz
sudo mkdir /srv/TeamCity
sudo mkdir /srv/.BuildServer

# create user
sudo useradd -m teamcity
sudo chown -R teamcity /srv/TeamCity

# create init.d script
sudo wget https://gist.githubusercontent.com/sandcastle/9282638/raw/teamcity-init.sh -O /etc/init.d/teamcity
sudo chmod 775 /etc/init.d/teamcity
sudo update-rc.d teamcity defaults


sudo mkdir -p /srv/.BuildServer/lib/jdbc
sudo mkdir -p /srv/.BuildServer/config

sudo wget https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-j-8.1.0.zip mysql-connector-j-8.1.0.zip
sudo unzip mysql-connector-j-8.1.0.zip
sudo mv mysql-connector-j-8.1.0/mysql-connector-j-8.1.0.jar /srv/.BuildServer//lib/jdbc/
sudo rm -rf mysql-connector-j-8.1.0
sudo rm -rf mysql-connector-j-8.1.0.zip

# ensure owership
sudo chown -R teamcity /srv/TeamCity
sudo chown -R teamcity /srv/.BuildServer
