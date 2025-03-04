#!/bin/bash
# Setup script for the Neovim plugin template

set -e

# ANSI color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print a colored message
print_message() {
  local color="$1"
  local message="$2"
  echo -e "${color}${message}${NC}"
}

print_message "$BLUE" "========================================"
print_message "$BLUE" "  Neovim Plugin Template Setup"
print_message "$BLUE" "========================================"
echo

# Get plugin name
read -p "Enter your plugin name (e.g. awesome-plugin): " PLUGIN_NAME
if [ -z "$PLUGIN_NAME" ]; then
  print_message "$RED" "Error: Plugin name cannot be empty"
  exit 1
fi

# Get plugin description
read -p "Enter a short description of your plugin: " PLUGIN_DESC
if [ -z "$PLUGIN_DESC" ]; then
  print_message "$YELLOW" "Warning: Using default description"
  PLUGIN_DESC="A Neovim plugin"
fi

# Get GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME
if [ -z "$GITHUB_USERNAME" ]; then
  print_message "$YELLOW" "Warning: Using 'username' as placeholder"
  GITHUB_USERNAME="username"
fi

# Get full name for license
read -p "Enter your full name for license: " FULL_NAME
if [ -z "$FULL_NAME" ]; then
  print_message "$YELLOW" "Warning: Using 'Full Name' as placeholder"
  FULL_NAME="Full Name"
fi

# Get email for security contacts
read -p "Enter your email for security contacts: " EMAIL
if [ -z "$EMAIL" ]; then
  print_message "$YELLOW" "Warning: Using 'email@example.com' as placeholder"
  EMAIL="email@example.com"
fi

# Get minimum Neovim version
read -p "Enter minimum Neovim version (default: 0.8.0): " NEOVIM_VERSION
if [ -z "$NEOVIM_VERSION" ]; then
  NEOVIM_VERSION="0.8.0"
fi

# Normalize plugin name for Lua modules
PLUGIN_MODULE=$(echo "$PLUGIN_NAME" | tr '-' '_')
YEAR=$(date +%Y)

print_message "$GREEN" "Setting up plugin with the following configuration:"
echo "  Plugin name: $PLUGIN_NAME"
echo "  Description: $PLUGIN_DESC"
echo "  GitHub: $GITHUB_USERNAME/$PLUGIN_NAME"
echo "  Full name: $FULL_NAME"
echo "  Email: $EMAIL"
echo "  Min Neovim: $NEOVIM_VERSION"
echo

# Ask for confirmation
read -p "Continue with this configuration? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  print_message "$RED" "Setup cancelled"
  exit 1
fi

# Rename plugin directories and files
print_message "$BLUE" "Renaming directories and files..."

# Update lua directory
if [ -d "lua/plugin-name" ]; then
  mkdir -p "lua/$PLUGIN_NAME"
  cp -r lua/plugin-name/* "lua/$PLUGIN_NAME/"
  rm -rf lua/plugin-name
  print_message "$GREEN" "✓ Updated lua directory"
fi

# Update plugin directory
if [ -d "plugin" ] && [ -f "plugin/plugin-name.lua" ]; then
  mv "plugin/plugin-name.lua" "plugin/$PLUGIN_NAME.lua"
  print_message "$GREEN" "✓ Updated plugin directory"
fi

# Update doc directory
if [ -d "doc" ] && [ -f "doc/plugin-name.txt" ]; then
  mv "doc/plugin-name.txt" "doc/$PLUGIN_NAME.txt"
  print_message "$GREEN" "✓ Updated doc directory"
fi

# Replace placeholders in files
print_message "$BLUE" "Updating file contents..."

# Update README.md
if [ -f "README.md" ]; then
  sed -i "s/Neovim Plugin Template/$PLUGIN_NAME/g" README.md
  sed -i "s/plugin-name/$PLUGIN_NAME/g" README.md
  sed -i "s/username/$GITHUB_USERNAME/g" README.md
  sed -i "s/A template for creating Neovim plugins with best practices and standardized structure/$PLUGIN_DESC/g" README.md
  print_message "$GREEN" "✓ Updated README.md"
fi

# Update Lua files
if [ -f "lua/$PLUGIN_NAME/init.lua" ]; then
  sed -i "s/plugin-name/$PLUGIN_NAME/g" "lua/$PLUGIN_NAME/init.lua"
  sed -i "s/plugin_name/$PLUGIN_MODULE/g" "lua/$PLUGIN_NAME/init.lua"
  print_message "$GREEN" "✓ Updated init.lua"
fi

# Update plugin loader
if [ -f "plugin/$PLUGIN_NAME.lua" ]; then
  sed -i "s/plugin-name/$PLUGIN_NAME/g" "plugin/$PLUGIN_NAME.lua"
  print_message "$GREEN" "✓ Updated plugin loader"
fi

# Update documentation
if [ -f "doc/$PLUGIN_NAME.txt" ]; then
  sed -i "s/plugin-name/$PLUGIN_NAME/g" "doc/$PLUGIN_NAME.txt"
  sed -i "s/Description of your plugin functionality/$PLUGIN_DESC/g" "doc/$PLUGIN_NAME.txt"
  print_message "$GREEN" "✓ Updated documentation"
fi

# Update test files
if [ -f "tests/minimal-init.lua" ]; then
  sed -i "s/plugin-name/$PLUGIN_NAME/g" "tests/minimal-init.lua"
  sed -i "s/plugin_name/$PLUGIN_MODULE/g" "tests/minimal-init.lua"
  print_message "$GREEN" "✓ Updated minimal-init.lua"
fi

if [ -f "tests/spec/plugin_spec.lua" ]; then
  sed -i "s/plugin-name/$PLUGIN_NAME/g" "tests/spec/plugin_spec.lua"
  sed -i "s/plugin_name/$PLUGIN_MODULE/g" "tests/spec/plugin_spec.lua"
  print_message "$GREEN" "✓ Updated test specs"
fi

# Update GitHub templates
find .github -type f -exec sed -i "s/username/$GITHUB_USERNAME/g" {} \;
find .github -type f -exec sed -i "s/plugin-name/$PLUGIN_NAME/g" {} \;
print_message "$GREEN" "✓ Updated GitHub templates"

# Update LICENSE
if [ -f "LICENSE" ]; then
  sed -i "s/\[year\]/$YEAR/g" LICENSE
  sed -i "s/\[fullname\]/$FULL_NAME/g" LICENSE
  print_message "$GREEN" "✓ Updated LICENSE"
fi

# Update CONTRIBUTING.md
if [ -f "CONTRIBUTING.md" ]; then
  sed -i "s/\[maintainer-email\]/$EMAIL/g" CONTRIBUTING.md
  sed -i "s/username\/plugin-name/$GITHUB_USERNAME\/$PLUGIN_NAME/g" CONTRIBUTING.md
  print_message "$GREEN" "✓ Updated CONTRIBUTING.md"
fi

# Update SECURITY.md
if [ -f "SECURITY.md" ]; then
  sed -i "s/security@example\.com/$EMAIL/g" SECURITY.md
  print_message "$GREEN" "✓ Updated SECURITY.md"
fi

# Update SUPPORT.md
if [ -f "SUPPORT.md" ]; then
  sed -i "s/username\/plugin-name/$GITHUB_USERNAME\/$PLUGIN_NAME/g" SUPPORT.md
  print_message "$GREEN" "✓ Updated SUPPORT.md"
fi

# Update CHANGELOG.md with initial version
if [ -f "CHANGELOG.md" ]; then
  CURRENT_DATE=$(date +"%Y-%m-%d")
  cat > "CHANGELOG.md" << EOF
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - $CURRENT_DATE

### Added
- Initial release
- Basic plugin structure and functionality
- Documentation and README
EOF
  print_message "$GREEN" "✓ Updated CHANGELOG.md"
fi

# Initialize git repository if needed
if [ ! -d ".git" ]; then
  print_message "$BLUE" "Initializing git repository..."
  git init
  git add .
  git commit -m "Initial commit: Set up $PLUGIN_NAME from template"
  print_message "$GREEN" "✓ Git repository initialized"
fi

# Add hooks-util as a submodule if it doesn't exist
if [ ! -d ".hooks-util" ]; then
  print_message "$BLUE" "Would you like to add hooks-util as a git submodule? (y/n)"
  read -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_message "$BLUE" "Adding hooks-util as a submodule..."
    git submodule add https://github.com/$GITHUB_USERNAME/hooks-util.git .hooks-util
    cd .hooks-util
    ./install.sh -c
    cd ..
    print_message "$GREEN" "✓ hooks-util added as a submodule"
  fi
fi

print_message "$GREEN" "Setup complete! 🎉"
print_message "$BLUE" "Next steps:"
echo "  1. Review and update the documentation files"
echo "  2. Implement your plugin functionality in lua/$PLUGIN_NAME/"
echo "  3. Write tests in tests/spec/"
echo "  4. Run 'make test' to test your plugin"
echo
print_message "$BLUE" "Happy coding! 💻"