-- plugin/plugin-name.lua
-- Plugin loader and command definitions

-- Define plugin commands
if vim.fn.has("nvim-0.8") == 0 then
  vim.notify("This plugin requires Neovim >= 0.8", vim.log.levels.ERROR)
  return
end

-- Create user commands for the plugin
vim.api.nvim_create_user_command("PluginNameCommand", function()
  require("plugin-name").some_function()
end, {
  desc = "Execute plugin's main function",
})

vim.api.nvim_create_user_command("PluginNameToggle", function()
  require("plugin-name").toggle()
end, {
  desc = "Toggle plugin on/off",
})

-- Auto-setup for lazy loading
-- Uncomment if needed
-- if vim.fn.has("vim_starting") == 1 then
--   vim.cmd([[autocmd VimEnter * ++once lua require("plugin-name").setup()]])
-- end