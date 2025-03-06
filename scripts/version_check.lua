#!/usr/bin/env lua
-- Version Check Script
-- Validates version consistency across project files

-- Configuration
local config = {
  -- Known files that should contain version information
  version_files = {
    -- Main source of truth
    { path = "lua/%s/version.lua", pattern = 'return "([%d%.]+)"', required = true },
    -- Documentation files
    { path = "README.md", pattern = "Version: v([%d%.]+)", required = true },
    { path = "CHANGELOG.md", pattern = "## %[([%d%.]+)%]", required = true },
    -- Optional source files
    { path = "lua/%s/init.lua", pattern = 'version = "([%d%.]+)"', required = false },
    { path = "lua/%s.lua", pattern = 'version = "([%d%.]+)"', required = false },
    -- Package files
    { path = "%s.rockspec", pattern = 'version = "([%d%.]+)"', required = false },
    { path = "package.json", pattern = '"version": "([%d%.]+)"', required = false },
  },
}

-- Get the project name from the script argument or from the current directory
local project_name = arg[1]
if not project_name then
  local current_dir = io.popen("basename `pwd`"):read("*l")
  project_name = current_dir:gsub("%-", "_")
end

-- Function to read a file's content
local function read_file(path)
  local file, err = io.open(path, "r")
  if not file then
    return nil, err
  end
  local content = file:read("*a")
  file:close()
  return content
end

-- Function to extract version from file using pattern
local function extract_version(path, pattern)
  local content, err = read_file(path)
  if not content then
    return nil, "Could not read " .. path .. ": " .. tostring(err)
  end

  local version = content:match(pattern)
  return version
end

-- Format path with project name
local function format_path(path_template)
  return path_template:format(project_name)
end

-- Check if a file exists
local function file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  end
  return false
end

-- Main version checking function
local function check_versions()
  local has_errors = false
  local canonical_version
  local checked_files = {}

  print("Checking version consistency...")

  -- First, get the canonical version from version.lua
  local version_file_path = format_path(config.version_files[1].path)
  canonical_version = extract_version(version_file_path, config.version_files[1].pattern)

  if not canonical_version then
    print("ERROR: Could not find canonical version in " .. version_file_path)
    print("ERROR: Cannot proceed without canonical version")
    has_errors = true
    return false
  end

  print("Canonical version: v" .. canonical_version)
  checked_files[version_file_path] = canonical_version

  -- Check each file
  for i, file_config in ipairs(config.version_files) do
    if i > 1 then -- Skip the first one, which we already checked
      local path = format_path(file_config.path)

      if file_exists(path) then
        local version = extract_version(path, file_config.pattern)

        if version then
          if version ~= canonical_version then
            print(
              string.format("ERROR: Version mismatch in %s: expected %s, found %s", path, canonical_version, version)
            )
            has_errors = true
          else
            print(string.format("✓ %s: v%s", path, version))
          end
          checked_files[path] = version
        else
          if file_config.required then
            print("ERROR: Could not find version in " .. path)
            has_errors = true
          else
            print("ℹ️ Skipping optional file: " .. path .. " (version pattern not found)")
          end
        end
      else
        if file_config.required then
          print("ERROR: Required file not found: " .. path)
          has_errors = true
        else
          print("ℹ️ Skipping optional file: " .. path .. " (not found)")
        end
      end
    end
  end

  -- Output results
  if has_errors then
    print("\nFound version inconsistencies")
    return false
  else
    print("\nAll versions are consistent! 🎉")
    return true
  end
end

-- Run the version check
local success = check_versions()
if not success then
  os.exit(1)
end

-- Return the canonical version for other scripts to use
return extract_version(format_path(config.version_files[1].path), config.version_files[1].pattern)
