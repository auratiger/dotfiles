local M = {}

M.setup = function()
   local opts = { noremap = true, silent = true }
   local keymap = vim.api.nvim_set_keymap

   keymap("v", "p", '"_dP', opts) -- this setting makes it so pasting over selected text doesn't override the top register
   keymap("n", "Q", "@q", opts) -- Run macro bound to q with Q

   -- F12 toggles relativenumber
   keymap("n", "<F12>", ":set relativenumber!<CR>", opts)

   -- Hitting escape also clears spelling and search highlights
   keymap("n", "<ESC>", ":nohls |:set norelativenumber | :setlocal nospell<ESC>", opts)

   -- When you search, center the result and open any folds
   keymap("n", "n", "nzzzv", opts)

   -- When you search backwards, center the result and open any folds
   keymap("n", "N", "Nzzzv", opts)

   -- Yank from the current position to the end of the line
   keymap("n", "Y", "y$", opts)

   -- Yank and paste to clipboard
   keymap("n", "y", '"+y', opts)
   keymap("n", "Y", '"+y$', opts)
   keymap("n", "p", '"+p', opts)
   keymap("n", "P", '"+P', opts)

   local mappings = {
      insert_mode = {
      },

      normal_mode = {
         -- Resize with arrows
         ["<C-Up>"] = ":resize -4<CR>",
         ["<C-Down>"] = ":resize +4<CR>",
         ["<C-Left>"] = ":vertical resize -4<CR>",
         ["<C-Right>"] = ":vertical resize +4<CR>",

         ["<S-l>"] = ":bnext<CR>",
         ["<S-h>"] = ":bprevious<CR>",

         ["zn"] = "zj", -- Goes to next fold
         ["zN"] = "zk", -- Goes to prev fold
         ["zj"] = "zo", -- Closes fold under cursor
         ["zk"] = "zc", -- Opens fold under cursor
         ["zJ"] = "zM", -- Closes all folds
         ["zK"] = "zR", -- Opens all folds

         ["<C-s>"] = ":w<cr>"

      },

      term_mode = {
      },

      visual_mode = {
      },

      visual_block_mode = {
      },

      command_mode = {
      },
   }

   for mode, values in pairs(mappings) do
      for k, v in pairs(values) do
         lvim.keys[mode][k] = v;
      end
   end

   M.bind_typescript_keybinds()
end

M.bind_typescript_keybinds = function()
   -- TODO: check if TSL is installed and research plugin
   -- better keybindings for ts and tsx files
   -- local langs = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
   -- local ftype = vim.bo.filetype
   -- if vim.tbl_contains(langs, ftype) then
   --    vim.api.nvim_set_keymap("n", "gA", "<cmd>TSLspImportAll<CR>", { noremap = true, silent = true })
   --    vim.api.nvim_set_keymap("n", "gr", "<cmd>TSLspRenameFile<CR>", { noremap = true, silent = true })
   --    vim.api.nvim_set_keymap("n", "gS", "<cmd>TSLspOrganize<CR>", { noremap = true, silent = true })
   -- end
end

return M
