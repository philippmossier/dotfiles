local util = require("lspconfig.util")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- default values can be found at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss
          root_dir = util.root_pattern('.git'), -- use this line only for monorepos like t3turbo
          settings = {
            tailwindCSS = {
              experimental = {
                -- configFile = vim.fn.stdpath("config") .. "/tailwind.config.js", -- monorepo option 2 (try this if "root_dir = util.root_pattern('.git')" does not work for monorepos, make sure to put tailwind.config.js to /Users/phil/nvim)

                -- add special classRegex for tailwind to work anywhere
                -- classRegex = {
                --   -- twin macro
                --   "tw`([^`]*)",          -- tw`...`
                --   'tw="([^"]*)',         -- <div tw="..." />
                --   'tw={"([^"}]*)',       --  <div tw={"..."} />
                --   "tw\\.\\w+`([^`]*)",   -- tw.xxx`...`
                --   "tw\\(.*?\\)`([^`]*)", -- tw(Component)`...`
                -- },
              },
            },
          },
        },
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      -- original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
    -- use sources and performance if you have tailwind autocomplete performance issues
    sources = {
      name = "nvim_lsp",
      priority = 10,
      keyword_length = 6,
      group_index = 1,
      max_item_count = 30,
    },
    performance = {
      trigger_debounce_time = 500,
      throttle = 550,
      fetching_timeout = 80,
    },
  },
}
