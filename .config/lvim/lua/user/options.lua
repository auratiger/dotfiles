if vim.g.neovide then
  vim.opt.guifont = "MonoLisa:h24"

  vim.g.neovide_transparency = 1
  vim.g.transparency = 0.8
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_input_macos_alt_is_meta = false
end

lvim.log.level = "warn"
lvim.format_on_save = true

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.filters.custom = {}

lvim.builtin.treesitter.ignore_install = {}
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.project.detection_methods = { "lsp", "pattern" }
lvim.builtin.project.patterns = {
  ".git",
  "package-lock.json",
  "yarn.lock",
  "package.json",
  "requirements.txt",
  "config.lua"
}

vim.opt.shell = "/bin/zsh"
lvim.format_on_save = true

vim.o.linebreak = true
vim.o.wrap = false
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.o.termguicolors = true

local options = {
   showmode = true, -- we don't need to see things like -- INSERT -- anymore
   textwidth = 100,
   shiftwidth = 3, -- the number of spaces inserted for each indentation
   tabstop = 3, -- insert 3 spaces for a tab
   relativenumber = true, -- set relative numbered lines
   wrapmargin = 2,
   scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
   sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
   timeoutlen = 400, -- time to wait for a mapped sequence to complete (in milliseconds)

   -- Uses treesitter fold queries for finding and setting correct folds
   -- custom queries are possible, read: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#parser-configurations
   foldmethod = "expr",
   foldexpr = "nvim_treesitter#foldexpr()",
   foldenable = false -- by defalt all folds will be open
}

vim.cmd("set foldlevel=99")
vim.cmd("set clipboard+=unnamedplus")

for k, v in pairs(options) do
   vim.opt[k] = v
end

lvim.builtin.telescope.defaults.path_display = { shorten = 4, }
-- Alternative path display
-- lvim.builtin.telescope.defaults.path_display = { shorten = { len = 2, exclude = { 1, -1, -2 } } }

lvim.builtin.telescope.defaults.initial_mode = 'insert'
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.height = 0.85
lvim.builtin.telescope.defaults.layout_config.prompt_position = 'top'
lvim.builtin.telescope.defaults.layout_strategy = 'horizontal'
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75

lvim.builtin.telescope.defaults.mappings = {
   i = {
      ["<C-c>"] = actions.close,
      ["<C-j>"] = actions.cycle_history_next,
      ["<C-k>"] = actions.cycle_history_prev,
      ["<C-h>"] = actions.file_split,
      ["<C-v>"] = actions.file_vsplit,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<CR>"] =  actions.select_default,
      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,
   },
   n = {
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
   },
}
