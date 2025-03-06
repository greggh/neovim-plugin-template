# Project: Neovim Plugin Template

## Overview
Neovim Plugin Template provides a standardized starting point for creating Neovim plugins. It inherits from the base project template and adds Neovim-specific structure, development tools, testing framework configuration, and documentation patterns optimized for plugin development.

## Essential Commands
- Run Tests: `env -C /home/gregg/Projects/neovim/neovim-plugin-template lua tests/run_tests.lua`
- Check Formatting: `env -C /home/gregg/Projects/neovim/neovim-plugin-template stylua lua/ -c`
- Format Code: `env -C /home/gregg/Projects/neovim/neovim-plugin-template stylua lua/`
- Run Linter: `env -C /home/gregg/Projects/neovim/neovim-plugin-template luacheck lua/`
- Build Documentation: `env -C /home/gregg/Projects/neovim/neovim-plugin-template mkdocs build`
- Version Check: `env -C /home/gregg/Projects/neovim/neovim-plugin-template lua scripts/version_check.lua`

## Project Structure
- `/lua`: Main plugin code
- `/tests`: Test files with Neovim API mocking
- `/after/plugin`: Plugin initialization
- `/plugin`: Plugin loading and setup
- `/doc`: Vim help documentation
- `/.github`: GitHub workflows for Neovim plugins
- `/scripts`: Development utilities and helpers

## Current Focus
- Integrating nvim-toolkit modules as dependencies
- Ensuring proper inheritance from base-project-template
- Enhancing the test environment with better mocking
- Creating comprehensive development documentation
- Adding example usage for nvim-toolkit modules

## Documentation Links
- Tasks: `/home/gregg/Projects/docs-projects/neovim-ecosystem-docs/tasks/neovim-plugin-template-tasks.md`
- Project Status: `/home/gregg/Projects/docs-projects/neovim-ecosystem-docs/project-status.md`