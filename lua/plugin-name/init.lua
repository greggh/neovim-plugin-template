-- plugin-name/init.lua
-- Main entry point for your plugin

-- Plugin configuration
local config = {
  -- Default configuration options
  enabled = true,
  debug = false,
  -- Add your plugin's configuration options here
}

-- Main plugin module
local M = {}

---Setup function - called by user to configure the plugin
---@param opts table: User configuration options
M.setup = function(opts)
  -- Merge user configuration with defaults
  config = vim.tbl_deep_extend("force", config, opts or {})

  -- Validate configuration
  if type(config.enabled) ~= "boolean" then
    vim.notify("plugin-name: 'enabled' option must be boolean", vim.log.levels.ERROR)
    return
  end

  -- Add additional validations as needed

  -- Early return if disabled
  if not config.enabled then
    vim.notify("plugin-name is disabled", vim.log.levels.INFO)
    return
  end

  -- Set up autocommands if necessary
  vim.api.nvim_create_augroup("PluginName", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = "PluginName",
    pattern = { "lua", "vim" }, -- Adjust file types as needed
    callback = function()
      -- Your autocmd logic here
    end,
  })

  -- Load keymappings if necessary
  M.setup_keymaps()

  -- Log debug information
  if config.debug then
    vim.notify("plugin-name: plugin initialized with config: " .. vim.inspect(config), vim.log.levels.DEBUG)
  end
end

---Set up keymaps for the plugin
M.setup_keymaps = function()
  -- Example keymap setup
  local opts = { noremap = true, silent = true } -- Used for keymap functions

  -- Example of setting a keymap
  -- vim.keymap.set("n", "<leader>p", function() require("plugin-name").some_function() end, opts)

  -- Register with which-key if available
  local ok, wk = pcall(require, "which-key")
  if ok then
    wk.register({
      ["<leader>p"] = {
        name = "+plugin-name",
        f = { function() M.some_function() end, "Plugin Function" },
        t = { function() M.toggle() end, "Toggle Plugin" },
      }
    })
  end
end

---Example function that your plugin provides
M.some_function = function()
  -- Your plugin logic here
  vim.notify("plugin-name: some_function called", vim.log.levels.INFO)
end

---Toggle plugin enabled state
M.toggle = function()
  config.enabled = not config.enabled
  vim.notify("plugin-name: " .. (config.enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

---Get current configuration
---@return table: Current configuration
M.get_config = function()
  return config
end

return M