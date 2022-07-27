#!/bin/bash

sudo apt update
echo "Installing Apache2"
sudo apt install apache2

echo "Installing Mysql"
sudo apt install mysql-server

echo "Installing PHP"
sudo apt install php8.1 php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath

echo "Installing Nodejs"
sudo apt install nodejs

echo "Installing NPM"
sudo apt install npm
