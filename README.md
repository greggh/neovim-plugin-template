# Neovim Plugin Template

[![GitHub License](https://img.shields.io/github/license/greggh/neovim-plugin-template?style=flat-square)](https://github.com/greggh/neovim-plugin-template/blob/main/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/greggh/neovim-plugin-template?style=flat-square)](https://github.com/greggh/neovim-plugin-template/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/greggh/neovim-plugin-template?style=flat-square)](https://github.com/greggh/neovim-plugin-template/issues)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/greggh/neovim-plugin-template?style=flat-square)](https://github.com/greggh/neovim-plugin-template/commits/main)
[![Neovim Version](https://img.shields.io/badge/Neovim-0.8%2B-blueviolet?style=flat-square&logo=neovim)](https://github.com/neovim/neovim)
[![CI](https://img.shields.io/github/actions/workflow/status/greggh/neovim-plugin-template/ci.yml?branch=main&style=flat-square&logo=github)](https://github.com/greggh/neovim-plugin-template/actions/workflows/ci.yml)
[![Version](https://img.shields.io/badge/Version-0.1.1-blue?style=flat-square)](https://github.com/greggh/neovim-plugin-template/releases/tag/v0.1.1)
[![Discussions](https://img.shields.io/github/discussions/greggh/neovim-plugin-template?style=flat-square&logo=github)](https://github.com/greggh/neovim-plugin-template/discussions)

*A template for creating Neovim plugins with best practices and standardized structure*

[Features](#features) •
[Requirements](#requirements) •
[Installation](#installation) •
[Usage](#usage) •
[Configuration](#configuration) •
[Development](#development) •
[License](#license)

## Overview

This repository provides a template for creating Neovim plugins with a standardized structure and best practices. It includes:

- Complete plugin structure with entry points
- Documentation templates
- Test framework setup
- Code quality tools integration
- GitHub workflows for CI/CD
- Community health files

## Features

- **Complete Structure**: All necessary files and directories for a Neovim plugin
- **Documentation**: Templates for help docs and README
- **Testing**: Plenary-based test setup with minimal configuration
- **Code Quality**: StyLua and Luacheck configuration
- **CI/CD**: GitHub Actions workflows for testing, linting and releases
- **Community**: Templates for issues, PRs, and contributing guidelines

## Requirements

- Neovim >= 0.8.0
- Git for version control
- (Optional) StyLua for code formatting
- (Optional) Luacheck for static analysis

## Installation

### Creating a New Plugin

1. Use this template to create a new repository:
   ```bash
   git clone https://github.com/greggh/neovim-plugin-template.git my-awesome-plugin
   cd my-awesome-plugin
   ```

2. Run the setup script to customize the template:
   ```bash
   ./scripts/setup.sh
   ```

3. Update the documentation files with your plugin-specific information

### Installing the Plugin (For Users)

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "greggh/plugin-name",
  dependencies = {
    -- Add dependencies here
  },
  config = function()
    require("plugin-name").setup({
      -- Your configuration
    })
  end
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'greggh/plugin-name',
  requires = {
    -- Add dependencies here
  },
  config = function()
    require('plugin-name').setup({
      -- Your configuration
    })
  end
}
```

## Usage

After installation, you can use the plugin with the following commands:

```vim
:PluginNameCommand    " Execute the plugin's main function
:PluginNameToggle     " Toggle the plugin on/off
```

Key mappings (if using which-key):

- `<leader>pf` - Execute the plugin's main function
- `<leader>pt` - Toggle the plugin on/off

## Configuration

Default configuration:

```lua
require("plugin-name").setup({
  enabled = true,
  debug = false,
  -- Add other options here
})
```

| Option    | Type      | Default | Description           |
| --------- | --------- | ------- | --------------------- |
| `enabled` | `boolean` | `true`  | Enable/disable plugin |
| `debug`   | `boolean` | `false` | Enable debug logging  |

## Development

### Directory Structure

```
.
├── lua/
│   └── plugin-name/      # Plugin code
│       └── init.lua      # Main entry point
├── plugin/
│   └── plugin-name.lua   # Plugin load script
├── doc/
│   └── plugin-name.txt   # Help documentation
├── tests/
│   ├── minimal-init.lua  # Minimal config for testing
│   └── spec/             # Test specifications
│       └── plugin_spec.lua
├── .github/              # GitHub specific files
├── .stylua.toml          # StyLua configuration
├── .luacheckrc           # Luacheck configuration
└── README.md             # This file
```

### Testing

Run tests with:

```bash
make test
```

Or manually:

```bash
nvim --headless -u tests/minimal-init.lua -c "lua require('plenary.test_harness').test_directory('tests/spec')"
```

### Code Quality

Format code with StyLua:

```bash
stylua .
```

Lint code with Luacheck:

```bash
luacheck .
```

Both tools are integrated with the pre-commit hooks when using [hooks-util](https://github.com/greggh/hooks-util).

## License

This template is released under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Neovim](https://neovim.io/) - The core editor
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Testing framework
- [StyLua](https://github.com/JohnnyMorganz/StyLua) - Lua formatter
- [Luacheck](https://github.com/lunarmodules/luacheck) - Lua linter
- [hooks-util](https://github.com/greggh/hooks-util) - Git hooks framework

---

<p align="center">
  Made with ❤️ for the Neovim community
</p>

## Discussions

Have questions or ideas? Join the conversation in [GitHub Discussions](https://github.com/greggh/neovim-plugin-template/discussions).

- **Questions**: For help with using or developing the plugin
- **Ideas**: Suggest new features or improvements
- **Show and Tell**: Share how you're using this plugin
- **General**: For any other topics related to this plugin