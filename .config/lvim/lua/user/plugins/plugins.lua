local M = {}

M.setup = function()
   local configs = require("user.plugins.plugin-configs")

   lvim.builtin.alpha.active = true
   lvim.builtin.alpha.mode = "dashboard"
   -- lvim.builtin.notify.active = true
   lvim.builtin.terminal.active = true
   lvim.builtin.nvimtree.setup.view.side = "left"
   -- lvim.builtin.nvimtree.show_icons.git = 0
   -- if you don't want all the parsers change this to a table of the ones you want
   lvim.builtin.treesitter.ensure_installed = { "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
      "css", "rust", "java", "yaml", }
   lvim.builtin.treesitter.ignore_install = { "haskell" }
   lvim.builtin.treesitter.highlight.enabled = true
   lvim.builtin.treesitter.rainbow.enable = true

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


   -- Additional Plugins --
   lvim.plugins = {
      { "nvim-telescope/telescope-media-files.nvim" },
      { "milisims/nvim-luaref" },
      {
         "folke/trouble.nvim",
         requires = "kyazdani42/nvim-web-devicons",
         cmd = "TroubleToggle",
      },
      {
         "editorconfig/editorconfig-vim",
         config = function()
            vim.cmd([[ let g:EditorConfig_exclude_patterns = ['fugitive://.*'] ]])
         end,
      },
      -- {
      --   "mg979/vim-visual-multi",
      --   config = function()
      --     vim.cmd([[
      --             let g:VM_maps = {}
      --             let g:VM_mouse_mappings = 1
      --             ]])
      --   end,
      -- },
      {
         "p00f/nvim-ts-rainbow",
      },
      -- {
      --    "nvim-treesitter/nvim-treesitter-textobjects",
      --    config = function()
      --       configs.text_objects()
      --    end
      -- },
      {
         "norcalli/nvim-colorizer.lua",
         config = function()
            require("colorizer").setup({ "css", "scss", "html", "typescript", "javascript", "eruby" }, {
               RGB = true, -- #RGB hex codes
               RRGGBB = true, -- #RRGGBB hex codes
               RRGGBBAA = true, -- #RRGGBBAA hex codes
               rgb_fn = true, -- CSS rgb() and rgba() functions
               hsl_fn = true, -- CSS hsl() and hsla() functions
               css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
               css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
         end,
      },
      -- {
      --   "junegunn/vim-easy-align",
      --   setup = function()
      --     vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {
      --       noremap = false,
      --       silent = true,
      --     })
      --   end,
      -- },
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
         setup = configs.setup_indent_blankline,
         config = configs.indent_blankline
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
         "tpope/vim-repeat",
      },
      {
         "phaazon/hop.nvim",
         as = "hop",
         keys = { "s", "S" },
         config = function()
            require("hop").setup()
            vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
            vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
         end,
      },
      {
         "iamcco/markdown-preview.nvim",
         ft = "markdown",
         run = ":call mkdp#util#install()",
         config = function()
            vim.g.mkdp_auto_start = 1
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
         end
      },
      {
         'anuvyklack/fold-preview.nvim',
         requires = 'anuvyklack/keymap-amend.nvim',
         config = function()
            require('fold-preview').setup()
         end
      }
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

end

return M
