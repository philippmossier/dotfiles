return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,  -- <== this is the key
      exclude = {},     -- not required but keeps it clean
    },
  },
}
