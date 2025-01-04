vim.g.lazyvim_prettier_needs_config = false

-- Hide deprecation warnings
vim.g.deprecation_warnings = true

local opt = vim.opt
opt.inccommand = "split" -- preview incremental substitute
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.wrap = true -- Enable line wrap
opt.swapfile = false
