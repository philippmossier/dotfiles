return {
  -- dims inactive portions of the code you're editing. (manual with :Twilight or automaticly in zenmode)
  "folke/twilight.nvim",

  -- for splitting/joining blocks of code like arrays, statements, objects with the J key
  {
    "Wansmer/treesj",
    enabled = false,
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  -- use this instead of treesj
  {
    "echasnovski/mini.splitjoin",
    opts = { mappings = { toggle = "J" } },
    keys = {
      { "J", desc = "Split/Join" },
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        -- width = 120, -- width of the Zen window
        width = 0.85, -- width will be 85% of the editor width
      },
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
