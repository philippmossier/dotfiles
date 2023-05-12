-- if true then
--   return {}
-- end
--
local util = require("lspconfig.util")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- default_config = { root_dir = "/Users/phil/twtest/tailwind.config.ts" },
          -- experimental = {
          --   -- configFile = vim.fn.stdpath("config") .. "/tailwind/index.ts",
          --   -- configFile = "packages/config/tailwind/index.ts",
          --   -- configFile = "/tailwind/index.ts",
          --   -- configFile = "/Users/phil/twurbonpm/packages/config/tailwind/index.ts"
          --   configFile = "/Users/phil/twtest/tailwind.config.ts",

          -- root_dir = { util.root_pattern("tailwind.config.js") },
          -- root_dir = function(fname)
          --   return util.root_pattern(
          --     "/packages/configs/tailwind/tailwind.config.js",
          --     "packages/configs/tailwind/tailwind.config.ts"
          --   )(fname) or util.root_pattern(
          --     "/packages/config/tailwind/tailwind.config.js",
          --     "packages/config/tailwind/tailwind.config.ts"
          --   )(fname) or util.root_pattern(
          --     "/packages/config/tailwind/index.ts",
          --     "packages/config/tailwind/index.js"
          --   )(fname) or util.root_pattern(
          --     "/packages/config/tailwind/postcss.config.ts",
          --     "packages/config/tailwind/postcss.config.js"
          --   )(fname) or util.root_pattern("postcss.config.js", "postcss.config.ts")(fname) or util.find_package_json_ancestor(
          --     fname
          --   ) or util.find_node_modules_ancestor(fname) or util.find_git_ancestor(fname)
          -- end,

          -- use this root_dir for t3turbo monorepo and/or with settings.tailwindCss.experimental.configFile = "/Users/phil/lastturbo/packages/config/tailwind/index.ts"
          root_dir = function(fname) return util.find_git_ancestor(fname) end, -- only use this line for some monorepos
          settings = {
            tailwindCSS = {
              experimental = {
                -- configFile = "/Users/phil/lastturbo/packages/config/tailwind/index.ts",
                -- configFile = util.root_pattern("config") .. "/packages/config/tailwind/index.ts",

                -- if the root_dir or configFile above does not work for your monorepo: remove root_dir and use just configFile on the next line
                -- configFile = vim.fn.stdpath("config") .. "/tailwind.config.js", -- put tailwind.config.js into /Users/phil/.config/nvim (sometimes a empty tailwind.config.js is enough)

                -- add special classRegex for tailwind to work anywhere
                classRegex = {
                  -- twin macro
                  "tw`([^`]*)",          -- tw`...`
                  'tw="([^"]*)',         -- <div tw="..." />
                  'tw={"([^"}]*)',       --  <div tw={"..."} />
                  "tw\\.\\w+`([^`]*)",   -- tw.xxx`...`
                  "tw\\(.*?\\)`([^`]*)", -- tw(Component)`...`

                  -- for haml :D
                  -- "%\\w+([^\\s]*)",
                  -- "\\.([^\\.]*)",
                  -- ':class\\s*=>\\s*"([^"]*)',
                  -- 'class:\\s+"([^"]*)',
                  --
                },
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
