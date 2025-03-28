#!/bin/bash

# Prompt for the module name
read -p "Enter the module name (e.g., my_module): " MODULE_NAME
MODULE_NAME_LOWER=$(echo "$MODULE_NAME" | tr '[:upper:]' '[:lower:]')

# Define module directory
MODULE_DIR="docroot/modules/custom/$MODULE_NAME_LOWER"

# Create module directory structure
mkdir -p "$MODULE_DIR"

# Create .info.yml file
cat <<EOL > "$MODULE_DIR/$MODULE_NAME_LOWER.info.yml"
name: $MODULE_NAME
type: module
description: 'A custom module for Drupal.'
package: Custom
core_version_requirement: ^8 || ^9
dependencies: []
EOL

# Create .module file
cat <<EOL > "$MODULE_DIR/$MODULE_NAME_LOWER.module"
<?php

/**
 * @file
 * Contains $MODULE_NAME module.
 */

/**
 * Implements hook_help().
 */
function ${MODULE_NAME_LOWER}_help(\$route_name, \$route_match) {
  switch (\$route_name) {
    case 'help.page.$MODULE_NAME_LOWER':
      return '<p>' . t('Help content for the $MODULE_NAME module.') . '</p>';
  }
}
EOL

# Create .routing.yml file
cat <<EOL > "$MODULE_DIR/$MODULE_NAME_LOWER.routing.yml"
$MODULE_NAME_LOWER.help:
  path: '/admin/help/$MODULE_NAME_LOWER'
  defaults:
    _controller: 'Drupal\\$MODULE_NAME_LOWER\\Controller\\${MODULE_NAME}Controller::help'
    _title: '$MODULE_NAME'
  requirements:
    _permission: 'access administration pages'
EOL

# Create a Controller directory and file
mkdir -p "$MODULE_DIR/src/Controller"
cat <<EOL > "$MODULE_DIR/src/Controller/${MODULE_NAME}Controller.php"
<?php

namespace Drupal\\$MODULE_NAME_LOWER\\Controller;

use Drupal\Core\Controller\ControllerBase;

/**
 * Returns responses for $MODULE_NAME routes.
 */
class ${MODULE_NAME}Controller extends ControllerBase {

  /**
   * Returns a help page.
   *
   * @return array
   *   A render array containing the help page content.
   */
  public function help() {
    return [
      '#markup' => '<p>' . t('Help content for the $MODULE_NAME module.') . '</p>',
    ];
  }

}
EOL

# Print success message
echo "Custom module '$MODULE_NAME' created successfully at '$MODULE_DIR'."
