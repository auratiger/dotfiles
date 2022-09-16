local M = {}

M.setup_indent_blankline = function()
   vim.g.indentLine_enabled = 1
   vim.g.indent_blankline_char = "▕"
   vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
   vim.g.indent_blankline_buftype_exclude = { "terminal" }
   vim.g.indent_blankline_show_trailing_blankline_indent = false
   vim.g.indent_blankline_show_first_indent_level = false
   vim.opt.list = true
   vim.opt.listchars:append("eol:↴")
end

M.indent_blankline = function()
   require("indent_blankline").setup {
      show_end_of_line = true,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
   }
end

M.text_objects = function()
   require('nvim-treesitter.configs').setup()
end


return M
