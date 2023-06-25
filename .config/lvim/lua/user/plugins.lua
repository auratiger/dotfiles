lvim.plugins = {
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestions = { enabled = false },
  --       panel = { enabled = false },
  --     })
  --   end,
  -- },

  { "hrsh7th/cmp-cmdline" },
  { 'jose-elias-alvarez/typescript.nvim' },
  { "p00f/nvim-ts-rainbow", },
  { "milisims/nvim-luaref" },
  { 'lunarvim/lunar.nvim' },
  { "morhetz/gruvbox" },
  { "sainnhe/gruvbox-material" },
  { "sainnhe/sonokai" },
  { "sainnhe/edge" },
  { "lunarvim/horizon.nvim" },
  { "tomasr/molokai" },
  { "ayu-theme/ayu-vim" },

  {
     "NvChad/nvim-colorizer.lua",
     config = function()
        require("colorizer").setup({
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
              mode = "foreground", -- Set the display mode.
              -- Available methods are false / true / "normal" / "lsp" / "both"
              -- True is same as normal
              tailwind = true, -- Enable tailwind colors
              -- parsers can contain values used in |user_default_options|
              sass = { enable = false, parsers = { css } }, -- Enable sass colors
              virtualtext = "■",
           },
        })
     end,
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

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
    end
  },

  {
     "iamcco/markdown-preview.nvim",
     ft = "markdown",
     build = ":call mkdp#util#install()",
     config = function()
        vim.g.mkdp_auto_start = 1
     end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" }
      })
    end
  },

  { "christoomey/vim-tmux-navigator" },
  { "tpope/vim-surround" },
  { "felipec/vim-sanegx", event = "BufRead" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { "tpope/vim-repeat" },

  { "ThePrimeagen/harpoon" },

  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup()
    end
  },

  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
  },

  {
    'AckslD/nvim-trevJ.lua',
    config = 'require("trevj").setup()',
    init = function()
      vim.keymap.set('n', '<leader>j', function()
        require('trevj').format_at_cursor()
      end)
    end,
  },
}

-- table.insert(lvim.plugins, {
--   "zbirenbaum/copilot-cmp",
--   event = "InsertEnter",
--   dependencies = { "zbirenbaum/copilot.lua" },
--   config = function()
--     local ok, cmp = pcall(require, "copilot_cmp")
--     if ok then cmp.setup({}) end
--   end,
-- })

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "frecency")
end
