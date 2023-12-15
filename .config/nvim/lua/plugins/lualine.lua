-- the opts function can also be used to change the default opts:
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, "😄")
  end,
}
