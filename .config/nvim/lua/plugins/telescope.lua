local actions = require("telescope.actions")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    { "<leader>,", false },
    { "<leader><space>", false },
    { "<leader>fb", false },
    { "<leader>fc", false },
    { "<leader>sb", false },
    { "<leader>sc", false },
    { "<leader>sC", false },
    { "<leader>sH", false },
    { "<leader>sk", false },
    { "<leader>sl", false },
    { "zs", ":lua require'telescope.builtin'.spell_suggest()<cr>", desc = "Spell Suggest" },
    { "<leader>sg", ":lua require'helpers.multi-ripgrep'()<cr>", desc = "Spell Suggest" },
  },
  opts = {
    pickers = {
      find_files = {
        theme = "ivy",
      },
    },
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
}
