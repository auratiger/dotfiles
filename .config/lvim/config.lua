local lvim = lvim
local vim = lvim


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.format_on_save = true
lvim.colorscheme = "lunar"
lvim.transparent_window = true

lvim.builtin.time_based_themes = false -- set false to use your own configured theme
lvim.debug = false
-- vim.lsp.set_log_level "error"
lvim.log.level = "warn"

-- Customization
-- =========================================
lvim.builtin.fancy_wild_menu = { active = true } -- enable/disable cmp-cmdline
lvim.builtin.cmp.cmdline.enable = true

-- Override Lunarvim defaults
-- =========================================
require "user.plugins.builtin".config()

require "user.options".setup()
require "user.mappings".setup()
require "user.whichkey".setup()
require "user.plugins.plugins".setup()

-- LSP
require "user.lsp"
