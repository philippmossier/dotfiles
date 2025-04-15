return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      explorer = {
        -- your explorer configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below

      },
      picker = {
        sources = {
          explorer = {
            -- your explorer picker configuration comes here
            -- or leave it empty to use the default settings
            -- auto_close = true,
            -- follow_file = true,
            -- auto_close = true,
            ignored = true,  -- Disable ignoring .gitignore files
            hidden = true,    -- Show hidden files
          },
        },
      },
    },
  },
}
