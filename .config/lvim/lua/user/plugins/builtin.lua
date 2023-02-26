local lvim = lvim

lvim.builtin.which_key.setup.icons.group = lvim.icons.ui.FolderOpen .. '  '

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- lvim.builtin.notify.active = true

lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0
--
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = { "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
   "css", "rust", "java", "yaml", }
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true


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
