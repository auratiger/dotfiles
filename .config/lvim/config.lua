--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- ===========================================================================
-- General
-- ===========================================================================
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "edge"
lvim.transparent_window = true

vim.opt.shiftwidth = 3
vim.opt.tabstop = 3
vim.opt.textwidth = 80
vim.opt.wrapmargin = 2

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

keymap("v", "p", '"_dP', opts) -- this setting makes it so pasting over selected text doesn't override the top register

lvim.keys.normal_mode = {
   ["zn"] = "zj", -- Goes to next fold
   ["zN"] = "zk", -- Goes to prev fold
   ["zj"] = "zo", -- Closes fold under cursor
   ["zk"] = "zc", -- Opens fold under cursor
   ["zJ"] = "zM", -- Closes all folds
   ["zK"] = "zR", -- Opens all folds
}

-- ===========================================================================
-- Use which-key to add extra bindings with the leader-key prefix
-- ===========================================================================
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.which_key.mappings["s"]["T"] = { "<cmd>Telescope grep_string<CR>", "Find Word" }

lvim.builtin.which_key.mappings["t"] = {
   name = "+Trouble",
   r = { "<cmd>Trouble lsp_references<cr>", "References" },
   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
   t = { "<cmd>TodoQuickFix<cr>", "Find Todo" },
   T = { "<cmd>TodoTelescope<cr>", "Find Todo Telescope" },
}

lvim.builtin.which_key.mappings["s"]["b"] = nil -- removes the duplicate branch mapping
lvim.builtin.which_key.mappings["T"] = nil -- removes the treesitter group mapping

-- ===========================================================================
-- Plugin Config
-- ===========================================================================
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
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

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


-- Additional Plugins
lvim.plugins = {
   { "folke/tokyonight.nvim" },
   { "sainnhe/edge" },
   { "nvim-telescope/telescope-media-files.nvim" },
   {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
   },
   {
      "p00f/nvim-ts-rainbow",
   },
   {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
      config = function()
         require("nvim-ts-autotag").setup()
      end,
   },
   -- {
   --   "metakirby5/codi.vim",
   --   cmd = "Codi",
   -- },
   {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      setup = function()
         vim.g.indentLine_enabled = 1
         vim.g.indent_blankline_char = "▕"
         vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
         vim.g.indent_blankline_buftype_exclude = { "terminal" }
         vim.g.indent_blankline_show_trailing_blankline_indent = false
         vim.g.indent_blankline_show_first_indent_level = false
         vim.opt.list = true
         vim.opt.listchars:append("eol:↴")
      end,
      config = function()
         require("indent_blankline").setup {
            show_end_of_line = true,
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
         }
      end
   },
   {
      "folke/todo-comments.nvim",
      event = "BufRead",
      config = function()
         require("todo-comments").setup()
      end,
   },
   {
      "tpope/vim-surround",
      keys = { "c", "d", "y" }
      -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
      -- setup = function()
      --  vim.o.timeoutlen = 500
      -- end
   },
   {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
         require("hop").setup()
         vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
         vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      end,
   },
   { 'anuvyklack/pretty-fold.nvim',
      requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
      config = function()
         vim.opt.foldcolumn = "1" -- sets the foldcolumn as always active with width of 1
         require('pretty-fold').setup({
            keep_indentation = false,
            fill_char = '━',
            border = "rounded",
            sections = {
               left = {
                  '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
               },
               right = {
                  '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
               }
            }
         })
         require('pretty-fold.preview').setup()
      end
   }

}

lvim.builtin.telescope.on_config_done = function(telescope)
   pcall(telescope.load_extension, "media_files")
   telescope.setup {
      defaults = {
         extensions = {
            media_files = {
               -- filetypes whitelist
               -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
               filetypes = { "png", "webp", "jpg", "jpeg" },
               find_cmd = "rg" -- find command (defaults to `fd`)
            }
         },
      }
   }
end

lvim.builtin.treesitter.rainbow.enable = true


-- generic LSP settings

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
   { command = "black", filetypes = { "python" } },
   { command = "isort", filetypes = { "python" } },
   {
      -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
      command = "prettier",
      ---@usage arguments to pass to the formatter
      -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
      extra_args = { "--print-with", "100", "--tab-width", 3 },
      ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
      filetypes = { "typescript", "typescriptreact" },
   },
   {
      command = "eslint",
      extra_args = { "indent", 3 },
      filetypes = { "typescript", "typescriptreact" },
   },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
   { command = "flake8", filetypes = { "python" } },
   -- {
   --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
   --   command = "shellcheck",
   --   ---@usage arguments to pass to the formatter
   --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
   --   extra_args = { "--severity", "warning" },
   -- },
   {
      command = "codespell",
      ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
      filetypes = { "javascript", "python" },
   },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
