-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "lunar"
lvim.transparent_window = true


require "user.options".setup()
require "user.mappings".setup()
require "user.whichkey".setup()
require "user.plugins.plugins".setup()

-- LSP
require "user.lsp"
