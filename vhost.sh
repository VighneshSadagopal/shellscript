#!/bin/bash
echo "Give a directory name to create:"
read Name
cd /etc/apache2/sites-available
sudo cp drupal.local.conf $Name.local.conf
sudo gedit $Name.local.conf
sudo a2dissite $Name.local.conf
sudo a2ensite $Name.local.conf
sudo gedit /etc/hosts
sudo systemctl reload apache2
echo "all done"
