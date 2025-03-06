#!/bin/bash
# Script to install git hooks for version management and other checks

set -e

echo "Installing Git Hooks..."

# Create hooks directory
mkdir -p .git/hooks

# Create symlink to pre-commit hook
ln -sf ../../.githooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

echo "✅ Git hooks installed successfully!"
echo
echo "To verify version consistency, run:"
echo "  lua scripts/version_check.lua"