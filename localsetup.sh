#!/bin/bash

sudo apt update

echo "Installing Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

echo "Installing Notion"
sudo snap install notion-snap

echo "Installing Slack"
sudo snap install slack

echo "Installing VScode"
sudo snap install code --classic

echo "Installing Zoom"
sudo snap install zoom-client
