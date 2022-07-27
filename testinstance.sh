#!/bin/bash
echo "Give a directory name to create:"
read name
echo "enter port:"
read a
echo "enter port:"
read b
cd /var/www/html
composer create-project drupal/recommended-project:9.3.12 $name
cd $name
mkdir -p web/sites/simpletest/browser_output
chmod +w web/sites/simpletest/browser_output
ddev config
cd .ddev
sed -i '4 s/8.0/7.4/' config.yaml
sed -i '6 s/80/'$a'/' config.yaml
sed -i '7 s/443/'$b'/' config.yaml
cd ../
ddev start
ddev composer require behat/mink-goutte-driver phpunit/phpunit phpspec/prophecy-phpunit:^2 behat/mink-selenium2-driver symfony/phpunit-bridge:^5.4 -W
cd ../

