local M = {}

M.setup = function()
   local mappings = lvim.builtin.which_key.mappings
   local vmappings = lvim.builtin.which_key.vmappings

   mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

   mappings["s"]["T"] = { "<cmd>Telescope grep_string<CR>", "Find Word" }

   mappings["D"] = {
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

   vmappings["l"] = {
      name = "+Lsp",
      r = { "<ESC><CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
   }

   mappings["r"] = {
      name = "Replace",
      o = { function() require('spectre').open() end, "Replace in project" },
      w = { function() require('spectre').open_visual({ select_word = true }) end, "Replace word" },
      f = { function() require('spectre').open_file_search() end, "Replace In file" },
      -- a  -- occupied by plugin
   }

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

      -- Navigate merge conflict markers
      ["]n"] = { "[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'W')<cr>]]", "next merge conflict" },
      ["[n"] = { "[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'bW')<cr>]]", "prev merge conflict" },
   }

   mappings[";"] = nil -- removes duplicate close option
   mappings["q"] = nil -- removes duplicate close option
   mappings["s"]["b"] = nil -- removes the duplicate branch mapping
   mappings["T"] = nil -- removes the treesitter group mapping
   mappings["l"]["w"] = nil -- removes the treesitter group mapping
   mappings["l"]["d"] = nil -- removes the treesitter group mapping
   mappings["l"]["j"] = nil -- removes the treesitter group mapping
   mappings["l"]["k"] = nil -- removes the treesitter group mapping
   mappings["l"]["e"] = nil -- removes the treesitter group mapping
end

return M
