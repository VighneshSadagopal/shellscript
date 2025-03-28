#!/bin/bash
echo "Give source to database file:"
read src
git clone git@bitbucket.org:drlglobal/acquia.git docvidya
cd docvidya
git checkout develop
git fetch --all
cd .ddev
sed -i '1 s/docvidya/drl/' config.yaml
sed -i '6 s/80/8443/' config.yaml
cd ../
git pull origin develop
ddev import-db --src=$src
cd docroot/themes/custom
npm install
cd drl_docvidya
npm run build:drupal
ddev composer install && ddev drush updatedb -y && ddev drush cim -y && ddev drush cr && git status
ddev drush uli