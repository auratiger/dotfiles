local kind = require('user.kind')

local wk = lvim.builtin.which_key

wk.setup.icons.group = lvim.icons.ui.FolderOpen .. '  '
wk.setup.window.winblend = 10
wk.setup.window.border = "none"
wk.setup.plugins.presets.z = true
wk.setup.plugins.presets.g = true
wk.setup.plugins.presets.windows = true
wk.setup.plugins.presets.nav = true
wk.setup.plugins.marks = true
wk.setup.plugins.registers = true
wk.setup.ignore_missing = true

wk.mappings["S"] = {
  name = " persistence.nvim",
  s = { "<cmd>lua require('persistence').load()<cr>", kind.icons.clock .. " Reload last session for dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", kind.icons.clock .. " Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", kind.icons.exit .. " Quit without saving session" },
}

wk.mappings["D"] = {
   name = "Diagnostics",
   r = { "<cmd>Trouble lsp_references<cr>", "References" },
   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
   e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
   l = { "<cmd>Trouble loclist<cr>", "Location List" },
   d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
   w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
   W = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
   t = { "<cmd>TodoQuickFix<cr>", "Find Todo" },
   T = { "<cmd>TodoTelescope<cr>", "Find Todo Telescope" },
}

wk.mappings["l"]["t"] = { ":LvimToggleFormatOnSave<cr>", kind.symbols_outline.File .. " Toggle format-on-save" }
wk.mappings["l"]["R"] = { ":LspRestart<cr>", kind.icons.exit .. " Restart" }

wk.mappings["s"]["w"] = {
  "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<cr>",
  ' ' .. kind.cmp_kind.EnumMember .. " Search Word Under Cursor"
}
wk.mappings["s"]["p"] = { ':Telescope projects<cr>', 'Find Projects' } -- requires telescope-project.nvim plugin
wk.mappings["s"]["P"] = { ':Telescope resume<cr>', 'Resume Project' }

wk.mappings["W"] = {
  name = ' ' .. kind.icons.screen .. " Window Ctrl",
  h = { '<C-w>|', 'Maximize window horizontally (|)' },
  v = { '<C-w>_', 'Maximize window vertically (_)' },
  ['='] = { '<C-w>=', 'Resize windows equally' },
  s = { ":lua require('telescope-tabs').list_tabs()<cr>", 'Search Tabs' },
}

wk.mappings["g"]["S"] = wk.mappings["g"]["s"]
wk.mappings["g"]["s"] = { function() require("telescope.builtin").git_status() end, "Git status" }
wk.mappings["g"]["L"] = { function() require("gitsigns").blame_line { full = true } end, "View full Git blame" }

wk.mappings['x'] = { ":xa<cr>", "Save All and Quit", }

wk.mappings["P"] = wk.mappings["p"]
wk.mappings["p"] = nil

local whk_status, whk = pcall(require, "which-key")
if not whk_status then
   return
end

whk.register {
   -- Harpoon
   ["<leader>a"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", " Add Mark" },
   ["<leader><leader>"] = {
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
      "Harpoon",
   },
   ["<leader>1"] = { "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", "goto1" },
   ["<leader>2"] = { "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", "goto2" },
   ["<leader>3"] = { "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", "goto3" },
   ["<leader>4"] = { "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", "goto4" },
   ["<leader>5"] = { "<CMD>lua require('harpoon.ui').nav_file(5)<CR>", "goto5" },
   ["<leader>6"] = { "<CMD>lua require('harpoon.ui').nav_file(6)<CR>", "goto6" },

   -- Navigate merge conflict markers
   ["]n"] = { ":call search('<<<<<<<\\|=======\\|>>>>>>>')<cr>", "next merge conflict" },
   ["[n"] = { ":call search('<<<<<<<\\|=======\\|>>>>>>>', 'bW')<cr>", "prev merge conflict" },
}


wk.mappings["T"] = nil -- removes the treesitter group mapping
wk.mappings["s"]["b"] = nil -- removes the duplicate branch mapping
wk.mappings["l"]["w"] = nil -- removes the treesitter group mapping
wk.mappings["l"]["d"] = nil -- removes the treesitter group mapping
wk.mappings["l"]["j"] = nil -- removes the treesitter group mapping
wk.mappings["l"]["k"] = nil -- removes the treesitter group mapping
wk.mappings["l"]["e"] = nil -- removes the treesitter group mapping
