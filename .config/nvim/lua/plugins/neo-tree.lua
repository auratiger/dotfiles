-- Nicer filetree than NetRW
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    indicator = {
      style = "underline",
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
