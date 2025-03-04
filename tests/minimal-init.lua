-- minimal-init.lua
-- Minimal configuration for testing

-- Set up package path
local package_path = vim.fn.stdpath("config") .. "/lua"
package.path = package.path .. ";" .. package_path .. "/?.lua;" .. package_path .. "/?/init.lua"

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.timeoutlen = 300
vim.opt.updatetime = 100
vim.opt.compatible = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false

-- Basic plugin loading code
local function load_plugin(plugin_name)
  -- Get the plugin path
  local plugin_path = debug.getinfo(2, "S").source:sub(2):match("(.*/tests)/.*$") .. "/.."
  
  -- Add the plugin to the runtimepath
  vim.opt.runtimepath:append(plugin_path)
  
  -- Attempt to load the plugin
  local status_ok, plugin = pcall(require, plugin_name)
  if not status_ok then
    vim.notify("Failed to load " .. plugin_name, vim.log.levels.ERROR)
    return nil
  end
  
  -- Return the loaded plugin
  return plugin
end

-- Setup the plugin
local plugin_name = "plugin-name"  -- Replace with your actual plugin name
local plugin = load_plugin(plugin_name)

if plugin then
  plugin.setup({
    -- Test configuration
    enabled = true,
    debug = true,
  })
  vim.notify(plugin_name .. " loaded successfully", vim.log.levels.INFO)
else
  vim.notify("Could not load " .. plugin_name, vim.log.levels.ERROR)
end

-- Return the loaded plugin for direct access in tests
return plugin