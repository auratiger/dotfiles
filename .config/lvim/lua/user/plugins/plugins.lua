local M = {}

local lvim = lvim

M.setup = function()
   -- local configs = require("user.plugins.plugin-configs")

   require "user.plugins.builtin"

   -- Additional Plugins --
   lvim.plugins = {
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
      {
         "nvim-treesitter/nvim-treesitter-textobjects",
         after = "nvim-treesitter",
      },
      {
         "NvChad/nvim-colorizer.lua",
         config = function()
            require("colorizer").setup {
               filetypes = { "css", "scss", "html", "typescript", "javascript", "lua" },
               user_default_options = {
                  RGB = true, -- #RGB hex codes
                  RRGGBB = true, -- #RRGGBB hex codes
                  names = true, -- "Name" codes like Blue or blue
                  RRGGBBAA = false, -- #RRGGBBAA hex codes
                  AARRGGBB = false, -- 0xAARRGGBB hex codes
                  rgb_fn = false, -- CSS rgb() and rgba() functions
                  hsl_fn = false, -- CSS hsl() and hsla() functions
                  css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                  css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                  -- Available modes for `mode`: foreground, background,  virtualtext
                  mode = "background", -- Set the display mode.
                  -- Available methods are false / true / "normal" / "lsp" / "both"
                  -- True is same as normal
                  tailwind = true, -- Enable tailwind colors
                  -- parsers can contain values used in |user_default_options|
                  sass = { enable = false, parsers = { css }, }, -- Enable sass colors
                  virtualtext = "■",
               }
            }
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
         'antosha417/nvim-lsp-file-operations',
         requires = {
            { "nvim-lua/plenary.nvim" },
            { "kyazdani42/nvim-tree.lua" },
         },
         config = function()
            require("lsp-file-operations").setup()
         end,
      },
      {
         "ThePrimeagen/harpoon",
         requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-lua/popup.nvim" },
         },
         config = function()
            require("harpoon").setup()
         end,
      },
      {
         "windwp/nvim-ts-autotag",
         config = function()
            require("nvim-ts-autotag").setup()
         end,
      },
      -- {
      --   "metakirby5/codi.vim",
      --   cmd = "Codi",
      -- },
      {
         "folke/todo-comments.nvim",
         event = "BufRead",
         config = function()
            -- TODO:
            -- FIX:
            -- HACK:
            -- PERF:
            -- WARN:
            -- NOTE:
            -- TEST:
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
         branch = 'v2', -- optional but strongly recommended
         event = "BufRead",
         config = function()
            require("hop").setup()
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
      },
      {
         "ray-x/lsp_signature.nvim",
         event = "BufRead",
         config = function()
            require "lsp_signature".on_attach({
               hint_enable = true, -- virtual hint enable
               hint_prefix = "", --  NOTE: for the terminal not support emoji, might crash
               hint_scheme = "String",
            })
         end,
      },
      {
         "windwp/nvim-spectre",
         event = "BufRead",
         config = function()
            require("spectre").setup({
               mapping = {
                  ['run_replace'] = {
                     map = "<leader>ra",
                     cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                     desc = "replace all"
                  },
                  ['show_option_menu'] = {
                     map = "<leader>o",
                     cmd = "<cmd>lua require('spectre').show_options()<CR>",
                     desc = "show option"
                  },
               }
            })
         end,
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
end

return M
