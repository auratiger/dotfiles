-- Themes
return {
  -- "xiyaowong/transparent.nvim",

  "typicode/bg.nvim",

  "ellisonleao/gruvbox.nvim",

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "italic" },
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = { "italic" },
        booleans = { "italic" },
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          Comment = { fg = "#89AEB1" },
          LineNr = { fg = colors.overlay0 },
        }
      end,
      integrations = {
        cmp = true,
        gitsigns = false,
        nvimtree = false,
        treesitter = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.bg_dark = "#373949"
        colors.bg = "#373949"
        colors.bg_visual = "#3e68d7"
      end,
    },
  },

  {
    "rose-pine/nvim",
    name = "rose-pine",
  },

  "sainnhe/everforest",

  "savq/melange-nvim",

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
