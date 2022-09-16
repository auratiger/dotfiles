local M = {}

M.setup = function()

   -- -- set a formatter, this will override the language server formatting capabilities (if it exists)
   local formatters = require "lvim.lsp.null-ls.formatters"
   formatters.setup {
      { command = "black", filetypes = { "python" } },
      { command = "isort", filetypes = { "python" } },
      {
         -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
         command = "prettier",
         ---@usage arguments to pass to the formatter
         -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
         extra_args = { "--print-with", "100", "--tab-width", 3 },
         ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
         filetypes = { "typescript", "typescriptreact" },
      },
      {
         command = "eslint",
         extra_args = { "indent", 3 },
         filetypes = { "typescript", "typescriptreact" },
      },
   }

   -- -- set additional linters
   local linters = require "lvim.lsp.null-ls.linters"
   linters.setup {
      { command = "flake8", filetypes = { "python" } },
      -- {
      --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
      --   command = "shellcheck",
      --   ---@usage arguments to pass to the formatter
      --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
      --   extra_args = { "--severity", "warning" },
      -- },
      {
         command = "codespell",
         ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
         filetypes = { "javascript", "python" },
      },
   }


end

return M
