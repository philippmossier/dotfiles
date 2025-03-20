return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 30, -- adjust the sidebar width
    },
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          -- auto-close neo-tree when a file is opened
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
