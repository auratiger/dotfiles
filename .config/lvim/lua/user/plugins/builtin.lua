local lvim = lvim
local M = {}

M.config = function()
   -- WhichKey
   -- =========================================
   lvim.builtin.which_key.setup.icons.group = lvim.icons.ui.FolderOpen .. '  '
   lvim.builtin.which_key.setup.window.winblend = 10
   lvim.builtin.which_key.setup.window.border = "none"
   lvim.builtin.which_key.setup.plugins.presets.z = true
   lvim.builtin.which_key.setup.plugins.presets.g = true
   lvim.builtin.which_key.setup.plugins.presets.windows = true
   lvim.builtin.which_key.setup.plugins.presets.nav = true
   lvim.builtin.which_key.setup.plugins.marks = true
   lvim.builtin.which_key.setup.plugins.registers = true
   lvim.builtin.which_key.setup.ignore_missing = true

   -- Alpha
   -- =========================================
   lvim.builtin.alpha.active = true
   lvim.builtin.alpha.mode = "dashboard"

   -- lvim.builtin.notify.active = true

   lvim.builtin.terminal.active = true

   lvim.builtin.nvimtree.setup.view.side = "left"
   -- lvim.builtin.nvimtree.show_icons.git = 0
   --
   -- Treesitter
   -- =========================================
   --
   -- if you don't want all the parsers change this to a table of the ones you want
   lvim.builtin.treesitter.ensure_installed = { "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
      "css", "rust", "java", "yaml", }
   lvim.builtin.treesitter.ignore_install = { "haskell" }
   lvim.builtin.treesitter.highlight.enabled = true
   lvim.builtin.treesitter.rainbow.enable = true

   lvim.builtin.treesitter.matchup.enable = true
   lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python" } } -- treesitter is buggy :(
   lvim.builtin.treesitter.query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
   }
   lvim.builtin.treesitter.textobjects = {
      select = {
         enable = true,
         lookahead = true,
         keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aA"] = "@attribute.outer",
            ["iA"] = "@attribute.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["ac"] = "@call.outer",
            ["ic"] = "@call.inner",
            ["at"] = "@class.outer",
            ["it"] = "@class.inner",
            ["a/"] = "@comment.outer",
            ["i/"] = "@comment.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["aF"] = "@frame.outer",
            ["iF"] = "@frame.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["is"] = "@scopename.inner",
            ["as"] = "@statement.outer",
            ["av"] = "@variable.outer",
            ["iv"] = "@variable.inner",
         },
      },
      swap = {
         enable = false,
      },
      move = {
         enable = true,
         set_jumps = true, -- whether to set jumps in the jumplist
         goto_next_start = {
            ["}}"] = "@parameter.inner",
            ["]]"] = "@function.outer",
         },
         goto_next_end = {
            ["]F"] = "@function.outer",
            ["]["] = "@class.outer",
         },
         goto_previous_start = {
            ["{{"] = "@parameter.inner",
            ["[["] = "@function.outer",
         },
         goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[]"] = "@class.outer",
         },
      },
   }

   local status_ok, actions = pcall(require, "telescope.actions")

   if not status_ok then
      print("Telescope not loaded.")
      return
   end

   lvim.builtin.telescope.defaults.path_display = { shorten = { len = 2, exclude = { 1, -1, -2 } } }
   lvim.builtin.telescope.pickers.live_grep = {
      theme = "dropdown",
      layout_config = {
         height = 0.4,
         preview_cutoff = 40,
         width = 0.6
      },
   }

   lvim.builtin.telescope.defaults.mappings = {
      i = {
         ["<C-c>"] = actions.close,
         ["<C-j>"] = actions.cycle_history_next,
         ["<C-k>"] = actions.cycle_history_prev,
         ["<C-h>"] = actions.file_split,
         ["<C-v>"] = actions.file_vsplit,
         ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
         ["<CR>"] = actions.select_default,
         ["<C-u>"] = actions.preview_scrolling_up,
         ["<C-d>"] = actions.preview_scrolling_down,
      },
      n = {
         ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
   }
end

return M
