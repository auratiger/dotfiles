-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keys = require("helpers.keys")
local map = keys.map
local dap_map = keys.dap_map

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>")
map("i", "jj", "<esc>")

map("", "<C-Z>", ":xa<cr>", "Save and Quit")
-- map() -- When you search, center the result and open any folds
-- map("n", "<C-u>", "<C-u>zz") -- When you search, center the result and open any folds

map("n", "<leader>h", "<cmd>nohlsearch<CR>", "No Highlight")

map("n", "<leader>k", function()
  local bd = require("mini.bufremove").delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 1 then -- Yes
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then -- No
      bd(0, true)
    end
  else
    bd(0)
  end
end, "Close Buffer")

map("n", "x", '"xx') -- Character delete uses specific register

-- Yank and paste to clipboard
map("n", "y", '"+y') -- yanks to specific register
map("n", "Y", '"+y$')
map("v", "p", '"_dP') -- this setting makes it so pasting over selected text doesn't override the top register
map("n", "P", '"+P')
map("n", "Q", "@q") -- Run macro bound to q with Q

-- Navigate merge conflict markers
map("n", "]n", ":call search('<<<<<<<\\|=======\\|>>>>>>>')<cr>", "next merge conflict")
map("n", "[n", ":call search('<<<<<<<\\|=======\\|>>>>>>>', 'bW')<cr>", "prev merge conflict")

-- First one: replace a word. This one the most common for me. I have a mapping for this.
--It search for the exact word under the cursor without moving it.
--Next, it replaces (inner) word and leaves you in insert mode.
--Once you replaced the first word you can use n to go to the next occurrence, then press.
--if you want to replace it.
map("n", "<leader>m", "<cmd>let @/='\\<'.expand('<cword>').'\\>'<cr>\"_ciw", "Word replace")

-- Second case: replace selection. It's a lot like replacing a word. The difference is you gotta do some shenanigans to the selection first.
map("x", "<leader>m", "y<cmd>let @/=substitute(escape(@\", '/'), '\\n', '\\n', 'g')<cr>\"_cgn", "Word replace")

local opts = { remap = true, silent = true }

local hop_ok, hop = pcall(require, "hop")
if hop_ok then
  local directions = require("hop.hint").HintDirection
  local modes = { "n", "o", "v" }

  dap_map(modes, "f", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  end, opts)

  dap_map(modes, "F", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  end, opts)

  dap_map(modes, "t", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  end, opts)

  dap_map(modes, "T", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  end, opts)

  dap_map(modes, "s", function()
    hop.hint_words({})
  end, opts)

  dap_map(modes, "S", function()
    hop.hint_vertical({})
  end, opts)
end

local ok, _ = pcall(require, "vim.diagnostic")
if ok then
  dap_map(
    "n",
    "ge",
    "<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.ERROR}})<cr>",
    opts
  )
  dap_map(
    "n",
    "gE",
    "<cmd>lua vim.diagnostic.goto_prev({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.ERROR}})<cr>",
    opts
  )
else
  print("[MAPPINGS]: vim.diagnostics not loaded")
end

-- Harpoon
map("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", " Add Mark")
map("n", "<leader>0", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon")

map("n", "<leader>1", "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", "goto1")
map("n", "<leader>2", "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", "goto2")
map("n", "<leader>3", "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", "goto3")
map("n", "<leader>4", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", "goto4")
map("n", "<leader>5", "<CMD>lua require('harpoon.ui').nav_file(5)<CR>", "goto5")
map("n", "<leader>6", "<CMD>lua require('harpoon.ui').nav_file(6)<CR>", "goto6")

-- folds
map("n", "zn", "zj", "Go to next fold")
map("n", "zN", "zk", "Go to prev fold")
map("n", "zj", "zo", "Open fold")
map("n", "zk", "zc", "Close fold")
map("n", "zJ", "zR", "Open all folds")
map("n", "zK", "zM", "Close all folds")

map("n", "<F3>", ":Lab code stop<CR>")
map("n", "<F4>", ":Lab code run<CR>")
map("n", "<F5>", ":Lab code panel<CR>")

-- Clear search with <esc>
-- map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- map(
--   "n",
--   "<leader>ur",
--   "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
--   { desc = "Redraw / clear hlsearch / diff update" }
-- )

--keywordprg
-- map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- highlights under cursor
-- map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
