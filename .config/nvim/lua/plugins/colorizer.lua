return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    lazy_load = true,
    filetypes = {
      "css",
      "scss",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "html",
    },
    user_default_options = {
      mode = "foreground",
    },
  },
}
