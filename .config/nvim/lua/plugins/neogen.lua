return {
  "danymat/neogen",
  cmd = "Neogen",
  keys = {
    {
      "<leader>cn",
      function()
        require("neogen").generate({ type = "func" })
      end,
      desc = "Generate Annotations (Neogen)",
    },
  },
  opts = {
    snippet_engine = "luasnip",
    languages = {
      lua = {
        template = {
          annotation_convention = "emmylua",
        },
      },
      typescriptreact = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
    },
  },
}
