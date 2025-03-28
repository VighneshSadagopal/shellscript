#!/bin/bash

# Prompt for the component name
read -p "Enter the component name: " COMPONENT_NAME

# Check if the user entered a component name
if [ -z "$COMPONENT_NAME" ]; then
  echo "Component name cannot be empty. Please try again."
  exit 1
fi

# Create a folder with the component name
mkdir "$COMPONENT_NAME"

# Change directory into the created folder
cd "$COMPONENT_NAME" || exit

# Create the files with the component name as a prefix
touch "${COMPONENT_NAME}.space.yml"
touch "${COMPONENT_NAME}.behavior.js"
touch "${COMPONENT_NAME}.twig"
touch "${COMPONENT_NAME}.css"
touch "${COMPONENT_NAME}.stories.jsx"
touch "index.js"

# Add content to the [component-name].stories.jsx file
cat <<EOL > "${COMPONENT_NAME}.stories.jsx"
import './index';

const patternDefinition = require('./${COMPONENT_NAME}.space.yml');

export const space = {
  patternDefinition,
};
EOL

# Add content to the index.js file
cat <<EOL > "index.js"
/**
 * ${COMPONENT_NAME}
 */
import './${COMPONENT_NAME}.css';
import './${COMPONENT_NAME}.behavior';
EOL

echo "Folder and files created for component: $COMPONENT_NAME"
