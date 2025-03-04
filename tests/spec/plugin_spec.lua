-- plugin_spec.lua
-- Tests for plugin functionality

-- Load test helpers
local plugin_name = 'plugin-name'  -- Replace with your actual plugin name

describe(plugin_name, function()
  -- Test setup function
  before_each(function()
    -- Reset any state between tests
    vim.cmd('lua package.loaded["' .. plugin_name .. '"] = nil')
    
    -- Re-load the plugin
    require(plugin_name).setup({
      enabled = true,
      debug = true,
    })
  end)

  -- Clean up after tests
  after_each(function()
    -- Close any buffers created during the test
    vim.cmd('silent! %bwipeout!')
  end)

  -- Test plugin initialization
  describe('initialization', function()
    it('loads successfully', function()
      -- Test that the plugin loaded correctly
      local plugin = require(plugin_name)
      assert.truthy(plugin)
      assert.truthy(plugin.setup)
    end)

    it('applies configuration', function()
      -- Test that configuration is applied correctly
      local plugin = require(plugin_name)
      plugin.setup({ debug = true })
      local config = plugin.get_config()
      assert.truthy(config)
      assert.equal(true, config.debug)
    end)
  end)

  -- Test plugin functionality
  describe('functionality', function()
    it('some_function works as expected', function()
      -- Test a specific functionality
      local plugin = require(plugin_name)
      assert.has_no.errors(function()
        plugin.some_function()
      end)
    end)

    it('toggle changes enable state', function()
      -- Test the toggle functionality
      local plugin = require(plugin_name)
      local initial_state = plugin.get_config().enabled
      plugin.toggle()
      assert.not_equal(initial_state, plugin.get_config().enabled)
    end)
  end)

  -- Additional test categories and tests
  describe('integration', function()
    it('works with other components', function()
      -- Test integration with other components (if applicable)
      -- Example: test integration with which-key, etc.
      pending("Integration tests to be implemented")
    end)
  end)
end)