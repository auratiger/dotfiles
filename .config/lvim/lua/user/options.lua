local M = {}

M.setup = function()
   vim.o.termguicolors = true

   local options = {
      showmode = true, -- we don't need to see things like -- INSERT -- anymore
      textwidth = 100,
      shiftwidth = 3, -- the number of spaces inserted for each indentation
      tabstop = 3, -- insert 3 spaces for a tab
      relativenumber = true, -- set relative numbered lines
      wrapmargin = 2,
      scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
      sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.

      -- Uses treesitter fold queries for finding and setting correct folds
      -- custom queries are possible, read: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#parser-configurations
      foldmethod = "expr",
      foldexpr = "nvim_treesitter#foldexpr()",
      foldenable = false -- by defalt all folds will be open
   }

   vim.cmd("set foldlevel=99")
   vim.cmd("set clipboard+=unnamedplus")

   for k, v in pairs(options) do
      vim.opt[k] = v
   end

end

return M
