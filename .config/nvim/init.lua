-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("luasnip.loaders.from_vscode").load({ paths = { "./snippets" } })
