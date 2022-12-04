local M = {}

M.setup = function()
   local mappings = lvim.builtin.which_key.mappings

   mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

   mappings["s"]["T"] = { "<cmd>Telescope grep_string<CR>", "Find Word" }

   mappings["D"] = {
      name = "Diagnostics",
      r = { "<cmd>Trouble lsp_references<cr>", "References" },
      f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
      q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
      l = { "<cmd>Trouble loclist<cr>", "Location List" },
      d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
      t = { "<cmd>TodoQuickFix<cr>", "Find Todo" },
      T = { "<cmd>TodoTelescope<cr>", "Find Todo Telescope" },
      p = { "<cmd>TodoTelescope<cr>", "test" },
   }

   mappings["R"] = {
      name = "Replace",
      r = { function() require('spectre').open() end, "Replace all" },
      w = { function() require('spectre').open_visual({ select_word = true }) end, "Replace word" },
      f = { function() require('spectre').open_file_search() end, "In file" },
   }

   mappings["q"] = nil -- removes duplicate close option
   mappings["s"]["b"] = nil -- removes the duplicate branch mapping
   mappings["T"] = nil -- removes the treesitter group mapping

end

return M
