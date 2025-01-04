return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<leader>b>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move the buffer to the right" },
    { "<leader>b<", "<Cmd>BufferLineMovePrev<CR>", desc = "Move the buffer to the left" },
  },
  opts = {
    options = {
      indicator = {
        style = "underline",
      },
      separator_style = "padded_slope",
    },
  },
}
