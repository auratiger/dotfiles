-- Nicer filetree than NetRW
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    indicator = {
      style = "underline",
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
    },
    window = {
      mappings = {
        ["h"] = "close_node",
        ["l"] = "open",
        ["a"] = {
          "add",
          nowait = true,
          config = {
            show_path = "relative",
          },
        },
      },
    },
  },
}
