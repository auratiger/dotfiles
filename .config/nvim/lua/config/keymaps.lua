local set = vim.keymap.set

local silent = { silent = true }

-- Blazingly fast way out of insert mode
set("i", "jk", "<esc>", silent)
set("i", "jj", "<esc>", silent)

set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
set("v", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Improves the escaping with j by directly returning the 'gj' command if you continue typing
set("n", "j", function(...)
  local count = vim.v.count
  if count == 0 then
    return "gj"
  else
    return "j"
  end
end, { expr = true })

-- Basic movement keybinds, these make navigating splits easy for me
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("", "<C-Z>", ":xa<cr>", { silent = true, desc = "Save and Quit" })
set("n", "<leader>h", "<cmd>nohlsearch<CR>", { silent = true, desc = "No Highlight" })

set("n", "x", '"xx', silent) -- Character delete uses specific register

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

set("n", "<leader>,", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename all word" })

-- Yank and paste to clipboard
set("n", "y", '"+y') -- yanks to specific register
set("n", "Y", '"+y$')
set("v", "p", '"_dP') -- this setting makes it so pasting over selected text doesn't override the top register
set("n", "P", '"+P')
set("n", "Q", "@q") -- Run macro bound to q with Q

-- Navigate merge conflict markers
set("n", "]n", ":call search('<<<<<<<\\|=======\\|>>>>>>>')<cr>", { silent = true, desc = "next merge conflict" })
set("n", "[n", ":call search('<<<<<<<\\|=======\\|>>>>>>>', 'bW')<cr>", { silent = true, desc = "prev merge conflict" })

-- First one: replace a word. This one the most common for me. I have a mapping for this.
--It search for the exact word under the cursor without moving it.
--Next, it replaces (inner) word and leaves you in insert mode.
--Once you replaced the first word you can use n to go to the next occurrence, then press.
--if you want to replace it.
set("n", "<leader>m", "<cmd>let @/='\\<'.expand('<cword>').'\\>'<cr>\"_ciw", { silent = true, desc = "Word replace" })
-- Second case: replace selection. It's a lot like replacing a word. The difference is you gotta do some shenanigans to the selection first.
set(
  "x",
  "<leader>m",
  "y<cmd>let @/=substitute(escape(@\", '/'), '\\n', '\\n', 'g')<cr>\"_cgn",
  { silent = true, desc = "Word replace" }
)

local ok, _ = pcall(require, "vim.diagnostic")
if ok then
  set(
    "n",
    "ge",
    "<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.ERROR}})<cr>",
    { remap = true, silent = true, desc = "Go to next error" }
  )
  set(
    "n",
    "gE",
    "<cmd>lua vim.diagnostic.goto_prev({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.ERROR}})<cr>",
    { remap = true, silent = true, desc = "Go to prev error" }
  )
else
  print("[MAPPINGS]: vim.diagnostics not loaded")
end

-- folds
set("n", "zn", "zj", { silent = true, desc = "Go to next fold" })
set("n", "zN", "zk", { silent = true, desc = "Go to prev fold" })
set("n", "zj", "zo", { silent = true, desc = "Open fold" })
set("n", "zk", "zc", { silent = true, desc = "Close fold" })
set("n", "zJ", "zR", { silent = true, desc = "Open all folds" })
set("n", "zK", "zM", { silent = true, desc = "Close all folds" })

-- Resize window using <ctrl> arrow keys
set("n", "<C-Up>", "<cmd>resize +5<cr>", { desc = "Increase Window Height" })
set("n", "<C-Down>", "<cmd>resize -5<cr>", { desc = "Decrease Window Height" })
set("n", "<C-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease Window Width" })
set("n", "<C-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase Window Width" })

local opts = { remap = true, silent = true }
local hop_ok, hop = pcall(require, "hop")
if hop_ok then
  local directions = require("hop.hint").HintDirection
  local modes = { "n", "o", "v" }

  set(modes, "f", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  end, opts)

  set(modes, "F", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  end, opts)

  set(modes, "t", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  end, opts)

  set(modes, "T", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  end, opts)

  set(modes, "s", function()
    hop.hint_words({})
  end, opts)

  set(modes, "S", function()
    hop.hint_vertical({})
  end, opts)
end
