#!/bin/bash

cd /

# install server dependencies
sudo apt-get update
sudo apt-get install -y openjdk-7-jre-headless
sudo apt-get install -y curl

# install build agent dependencies
sudo apt-get install -y mercurial
sudo apt-get install -y git

# install team city
sudo wget -c https://download.jetbrains.com/teamcity/TeamCity-2023.11.tar.gz -O /tmp/TeamCity-2023.11.tar.gz
sudo tar -xvf /tmp/TeamCity-2023.11.tar.gz -C /srv
sudo rm -rf /tmp/TeamCity-2023.11.tar.gz
sudo mkdir /srv/.BuildServer

# create user
sudo useradd -m teamcity
sudo chown -R teamcity /srv/TeamCity
sudo chown -R teamcity /srv/.BuildServer

# create init.d script
sudo wget https://gist.githubusercontent.com/sandcastle/9282638/raw/teamcity-init.sh -O /etc/init.d/teamcity
sudo chmod 775 /etc/init.d/teamcity
sudo update-rc.d teamcity defaults

# ensure owership
sudo chown -R teamcity /srv/TeamCity
sudo chown -R teamcity /srv/.BuildServer
