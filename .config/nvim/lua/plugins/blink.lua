return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-h>"] = { "scroll_documentation_up", "fallback" },
      ["<C-l>"] = { "scroll_documentation_down", "fallback" },
    },
  },
}
