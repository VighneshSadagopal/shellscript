#!/bin/bash
echo "Give a directory name to create:"
read Name
cd /var/www/html
mkdir $Name
cd $Name
composer create-project drupal/recommended-project drupal
cd drupal/web/sites/default
sudo cp default.settings.php settings.php
cd ../../../
sudo chmod -R 777 web/sites 
echo "
``````````````````````````````````````````````````````````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````
				SITE CREATED				
``````````````````````````````````````````````````````````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````"
cd /etc/apache2/sites-available
sudo cp drupal.local.conf $Name.local.conf
sudo gedit $Name.local.conf
sudo a2dissite $Name.local.conf
sudo a2ensite $Name.local.conf
sudo gedit /etc/hosts
sudo systemctl reload apache2

cd /var/www/html/$Name/drupal
composer require drush/drush:10.x
composer install --ignore-platform-reqs

echo "all done"
