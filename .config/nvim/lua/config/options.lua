-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_eslint_auto_format = false

-- Hide deprecation warnings
vim.g.deprecation_warnings = true

vim.g.snacks_animate = false

local opt = vim.opt
opt.inccommand = "split" -- preview incremental substitute
opt.smoothscroll = false
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.wrap = true -- Enable line wrap
opt.swapfile = false
opt.maxmempattern = 5000
