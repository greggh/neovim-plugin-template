# Makefile for Neovim plugin development

.PHONY: test lint format doc clean

# Default target
all: test lint

# Run tests
test:
	@echo "Running tests..."
	@nvim --headless -u tests/minimal-init.lua -c "lua require('plenary.test_harness').test_directory('tests/spec', {sequential = true})" || echo "Tests failed"

# Lint Lua files
lint:
	@echo "Linting Lua files..."
	@if command -v luacheck > /dev/null; then \
		luacheck .; \
	else \
		echo "luacheck not found. Please install it with 'luarocks install luacheck'"; \
	fi

# Format Lua files with StyLua
format:
	@echo "Formatting Lua files..."
	@if command -v stylua > /dev/null; then \
		stylua .; \
	else \
		echo "stylua not found. Please install it from https://github.com/JohnnyMorganz/StyLua"; \
	fi

# Generate documentation
doc:
	@echo "Generating documentation..."
	@if [ -f "scripts/generate-docs.sh" ]; then \
		bash scripts/generate-docs.sh; \
	else \
		echo "Documentation script not found"; \
	fi

# Clean temporary files
clean:
	@echo "Cleaning up..."
	@rm -rf .luarocks/ .install/ .coverage/

# Install hooks-util if not already installed
hooks:
	@echo "Setting up git hooks..."
	@if [ -d ".hooks-util" ]; then \
		cd .hooks-util && ./install.sh -c; \
	else \
		echo "hooks-util not found, installing..."; \
		git submodule add https://github.com/username/hooks-util.git .hooks-util; \
		cd .hooks-util && ./install.sh -c; \
	fi