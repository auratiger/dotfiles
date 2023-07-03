local kind = require('user.kind')

lvim.leader = "space"

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- =================== ESCAPE KEYS ===================

keymap("i", "jj", '<ESC>', opts)
keymap("i", "jk", '<ESC>', opts)

-- =================== NAVIGATION KEYS ===================

keymap('n', "<S-l>", ":bnext<CR>", opts)
keymap('n', "<S-h>", ":bprevious<CR>", opts)

vim.keymap.set('n', 'gn', ":tabe %<CR>")

local lvimmap = lvim.lsp.buffer_mappings
lvimmap.normal_mode["gr"] = {
  ":lua require'telescope.builtin'.lsp_references()<cr>",
  kind.cmp_kind.Reference .. " Find references"
}

lvimmap.normal_mode["gd"] = {
  -- ":lua vim.lsp.buf.definition()<cr>",
  ":lua require'telescope.builtin'.lsp_definitions()<cr>",
  kind.cmp_kind.Reference .. " Definitions"
}

lvimmap.normal_mode["gD"] = {
  ":lua vim.lsp.buf.type_definition()<cr>",
  kind.cmp_kind.Reference .. " Type Definition"
}

lvimmap.normal_mode["gf"] = {
  ":Telescope frecency<cr>",
  kind.cmp_kind.Reference .. " Telescope Frecency"
}

keymap("n", "gr",  "<cmd>lua vim.lsp.buf.references()<cr>" , opts) -- opens references of word under cursor

local ok, _ = pcall(require, "vim.diagnostic")
if ok then
  keymap("n", "ge",
     "<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.ERROR}})<cr>",
     opts)
  keymap("n", "gE",
     "<cmd>lua vim.diagnostic.goto_prev({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.ERROR}})<cr>",
     opts)
else
  print("[MAPPINGS]: vim.diagnostics not loaded")
end

-- =================== FUNCTION KEYS ===================
keymap("n", "<F4>", ":%s/", { noremap = true, silent = false }) -- F4
keymap("n", "<F8>", ":ToggleTerm<CR>", opts) -- F8 toggles terminal window
keymap("n", "<F9>", ":MarkdownPreviewToggle<CR>", opts) -- F9 toggles markdown preview
keymap("n", "<F12>", ":set relativenumber!<CR>", opts) -- F12 toggles relativenumber

keymap("n", "<C-d>", "<C-d>zz", opts) -- When you search, center the result and open any folds
keymap("n", "<C-u>", "<C-u>zz", opts) -- When you search, center the result and open any folds
keymap("n", "n", "nzzzv", opts) -- When you search, center the result and open any folds
keymap("n", "N", "Nzzzv", opts) -- When you search backwards, center the result and open any folds
keymap("n", "Y", "y$", opts) -- Yank from the current position to the end of the line

-- =================== OVERRIDES ===================
keymap("n", "x", '"xx', opts) -- Character delete uses specific register

-- Yank and paste to clipboard
keymap("n", "y", '"+y', opts)
keymap("n", "Y", '"+y$', opts)
keymap("n", "p", '"+p', opts)
keymap("v", "p", '"_dP', opts) -- this setting makes it so pasting over selected text doesn't override the top register
keymap("n", "P", '"+P', opts)
keymap("n", "Q", "@q", opts) -- Run macro bound to q with Q

-- folds
keymap('n', "zn", "zj", opts)
keymap('n', "zN", "zk", opts)
keymap('n', "zj", "zo", opts)
keymap('n', "zk", "zc", opts)
keymap('n', "zJ", "zM", opts)
keymap('n', "zK", "zR", opts)

keymap('', "<C-Z>", ":xa<cr>", opts) -- save and quit all
keymap('n', "<C-s>", ":w<cr>", opts) -- Save

-- Resize with arrows
keymap('n', "<C-UP>", ":resize -4<CR>", opts)
keymap('n', "<C-Down>", ":resize +4<CR>", opts)
keymap('n', "<C-Left>", ":vertical resize -4<CR>", opts)
keymap('n', "<C-Right>", ":vertical resize +4<CR>", opts)

keymap('v', "R", "<esc>:lua require('spectre').open_visual()<cr>", { silent = true })
