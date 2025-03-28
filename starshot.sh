#!/bin/bash

mkdir starshot && cd starshot
composer create drupal/recommended-project:^11
ddev config
ddev start
ddev composer require drupal/core-dev
ddev composer require drush/drush
ddev config --update
ddev restart
ddev drush site:install --account-name=admin --account-pass=admin -y
ddev launch $(ddev drush uli)


ddev composer config repositories.drupal-experience-builder vcs https://git.drupalcode.org/project/experience_builder.git
ddev composer require drupal/experience_builder:@dev
ddev drush pm:install experience_builder media media_library
cd web/modules/contrib/experience_builder/ui
ddev npm i
ddev npm run build
cd -
ddev drush cr