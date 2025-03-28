#!/bin/bash

# Ask for project details
echo "Enter the name of the project: "
read PROJECT_NAME

echo "Enter the version of Drupal (e.g., 10 or 11): "
read DRUPAL_VERSION

echo "Do you want to change 'web' to 'docroot'? (yes/no)"
read CHANGE_DOCROOT

echo "Do you want to create a custom module folder? (yes/no)"
read CREATE_MODULES

echo "Do you want to create a custom theme folder? (yes/no)"
read CREATE_THEMES


# Create project directory and initialize Drupal without installing dependencies
composer create-project --no-install drupal/recommended-project:^$DRUPAL_VERSION $PROJECT_NAME

# Change to project directory
cd $PROJECT_NAME || exit

# Change web root directory if needed
if [ "$CHANGE_DOCROOT" == "yes" ]; then
   sed -i 's/"web\//"docroot\//g' composer.json
fi



composer install


ddev config --project-type=drupal --docroot=docroot


# Create custom module folder if needed
if [ "$CREATE_MODULES" == "yes" ]; then
    mkdir -p docroot/modules/custom
    echo "Custom module folder created at docroot/modules/custom"
fi

# Create custom theme folder if needed
if [ "$CREATE_THEMES" == "yes" ]; then
    mkdir -p docroot/themes/custom
    echo "Custom theme folder created at docroot/themes/custom"
fi

ddev start

ddev composer require drush/drush

ddev drush site:install --account-name=admin --account-pass=admin -y

ddev drush uli
echo "Drupal $DRUPAL_VERSION project '$PROJECT_NAME' setup completed successfully!"
