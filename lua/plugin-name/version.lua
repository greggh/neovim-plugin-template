-- Plugin Version Information
-- This file serves as the single source of truth for version information
local M = {}

-- Follow semantic versioning (MAJOR.MINOR.PATCH)
-- Individual version components
M.major = 0
M.minor = 1
M.patch = 0

-- Combined semantic version
M.string = string.format("%d.%d.%d", M.major, M.minor, M.patch)

-- Other version information
M.min_neovim_version = "0.8.0"
M.homepage = "https://github.com/greggh/plugin-name"
M.license = "MIT"

-- Version check function
function M.check_nvim_version()
  local major, minor, _ = unpack(vim.version())
  local nvim_ver = string.format("%d.%d.0", major, minor)
  if vim.fn.has("nvim-" .. M.min_neovim_version) ~= 1 then
    vim.notify(
      string.format(
        "%s requires Neovim >= %s (current: %s). Please upgrade your Neovim installation.",
        "plugin-name",
        M.min_neovim_version,
        nvim_ver
      ),
      vim.log.levels.ERROR
    )
    return false
  end
  return true
end

-- String representation for use in statusline etc.
function M.get_version_string()
  return "v" .. M.version
end

return M
