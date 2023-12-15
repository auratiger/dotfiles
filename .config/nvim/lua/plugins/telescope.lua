local actions = require("telescope.actions")
local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>/", false },
      { "zs", ":lua require'telescope.builtin'.spell_suggest()<cr>", desc = "Spell Suggest" },
      { "<leader><leader>", "<Cmd>Telescope frecency workspace=CWD<CR>", desc = "Frecency" },
      { "<leader>st", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    },
    opts = {
      defaults = {
        path_display = { shorten = 4 },
        mappings = {
          i = {
            ["<C-h>"] = actions.file_split,
            ["<C-v>"] = actions.file_vsplit,
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-d>"] = actions.results_scrolling_down,
            ["<C-u>"] = actions.results_scrolling_up,

            ["<a-d>"] = actions.preview_scrolling_down,
            ["<a-u>"] = actions.preview_scrolling_up,
            ["<a-h>"] = actions.preview_scrolling_left,
            ["<a-l>"] = actions.preview_scrolling_right,
          },
          n = {
            ["<C-h>"] = actions.file_split,
            ["<C-v>"] = actions.file_vsplit,
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-d>"] = actions.results_scrolling_down,
            ["<C-u>"] = actions.results_scrolling_up,

            ["<a-d>"] = actions.preview_scrolling_down,
            ["<a-u>"] = actions.preview_scrolling_up,
            ["<a-j>"] = actions.preview_scrolling_down,
            ["<a-k>"] = actions.preview_scrolling_up,
            ["<a-h>"] = actions.preview_scrolling_left,
            ["<a-l>"] = actions.preview_scrolling_right,
          },
        },
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- add telescope-frecency
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
}
