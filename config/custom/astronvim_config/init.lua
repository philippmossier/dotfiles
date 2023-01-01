--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme to use -- disable yy, dd, to overwrite macos clipboard
  colorscheme = "nightfox", --"default_theme",

  -- Add highlight groups in any theme
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    -- }
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      -- set to true or false etc.
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "yes", -- this gives gitsigns a placeholder to fix indentation jumping ("https://superuser.com/questions/558876/how-can-i-make-the-sign-column-show-up-all-the-time-even-if-no-signs-have-been-a") "auto", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
      -- autoindent = true,
      clipboard = "", -- disable yy, dd, to overwrite macos clipboard
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
    " █████  ███████ ████████ ██████   ██████",
    "██   ██ ██         ██    ██   ██ ██    ██",
    "███████ ███████    ██    ██████  ██    ██",
    "██   ██      ██    ██    ██   ██ ██    ██",
    "██   ██ ███████    ██    ██   ██  ██████",
    " ",
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  },

  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = false,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = false,
    underline = true,
    update_in_insert = true, -- disables diagnostics when typing ( on null-ls with eslint update_in_insert works different (does not hide while typing))
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      filter = function(client) -- fully override the default formatting function
        -- only enable null-ls for provided file types (these files will only use null_ls for formatting)
        local ft = vim.bo.filetype
        if ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
          -- print("this worked")
          -- currently only null-ls , tsserver and tailwindcss come here.
          --  null-ls is also able to format tailwindcss classes ( so we just need null-ls for this filetypes)
          return client.name == "null-ls"
        end

        -- disable formatting for sumneko_lua
        -- if client.name == "sumneko_lua" then
        --   return false
        -- end

        -- disable formatting with all servers except null-ls
        -- if client.name ~= "null-ls" then
        --   -- client.server_capabilities.document_formatting = false
        --   return false
        -- end

        -- if client.name == "tsserver" then
        --   client.server_capabilities.document_formatting = false
        -- end

        return true
      end,
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

      -- my custom keymaps

      ["<leader>y"] = { '"+yy', desc = "Yank to clipboard" }, -- only needed when using vim.opt.clipboard=""
      -- ["yy"] = { "*yy", desc = "Yank without overwrite" },
    },
    v = {

      -- ["<leader>p"] = { '"_dP', desc = "Viewmode paste without cb overwrite" },
      ["<leader>y"] = { '"+y', desc = "Yank to clipboard" }, -- only needed when using vim.opt.clipboard=""
      ["p"] = { '"_dP', desc = "Viewmode paste without clipboard overwrite" },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      {
        "EdenEast/nightfox.nvim",
        config = function()
          require("nightfox").setup {
            options = {
              -- Compiled file's destination location
              compile_path = vim.fn.stdpath "cache" .. "/nightfox",
              compile_file_suffix = "_compiled", -- Compiled file suffix
              transparent = false, -- Disable setting background
              terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
              dim_inactive = true, -- Non focused panes set to alternative background
              module_default = true, -- Default enable value for modules
              styles = { -- Style to be applied to different syntax groups
                comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
                conditionals = "NONE",
                constants = "NONE",
                functions = "NONE",
                keywords = "NONE",
                numbers = "NONE",
                operators = "NONE",
                strings = "NONE",
                types = "NONE",
                variables = "NONE",
              },
              inverse = { -- Inverse highlight for different types
                match_paren = false,
                visual = false,
                search = false,
              },
              modules = { -- List of various plugins and additional options
                -- ...
              },
            },
            palettes = {
              nightfox = {
                -- default nightfox palette:
                -- comment = "#738091",
                --
                -- bg0 = "#131a24", -- Dark bg (status line and float)
                -- bg1 = "#192330", -- Default bg
                -- bg2 = "#212e3f", -- Lighter bg (colorcolm folds)
                -- bg3 = "#29394f", -- Lighter bg (cursor line)
                -- bg4 = "#39506d", -- Conceal, border fg
                --
                -- fg0 = "#d6d6d7", -- Lighter fg
                -- fg1 = "#cdcecf", -- Default fg
                -- fg2 = "#aeafb0", -- Darker fg (status line)
                -- fg3 = "#71839b", -- Darker fg (line numbers, fold colums)
                --
                -- sel0 = "#2b3b51", -- Popup bg, visual selection bg
                -- sel1 = "#3c5372", -- Popup sel bg, search bg
              },
            },
            specs = {},
            groups = {},
          }
        end,
      },

      -- markdown preview
      {
        -- if the plugin command :MarkdownPreview does not open the browser
        -- make sure that this plugin is installed correctly
        -- cd ~/.local/share/nvim/site/pack/packer/start/
        -- and make sure `yarn install` and `yarn build` was run
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown", "md" } end,
        ft = { "markdown", "md" }, -- this makes sure that this plugin only gets loaded when a buffer is attached to a markdown filetype
      },

      -- nvim-surround:
      {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
          require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
          }
        end,
      },
      {
        "ThePrimeagen/vim-be-good",
      },

      -- You can disable default plugins as follows:
      --     ["p00f/nvim-ts-rainbow"] = { disable = true },
      --     ["Darazaki/indent-o-matic"] = { disable = true },
      -- ["lukas-reineke/indent-blankline.nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- Add plugins, the packer syntax without the "use"
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },

      -- We also support a key value style plugin definition similar to NvChad:
      -- ["ray-x/lsp_signature.nvim"] = {
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },
    -- ["gitsigns"] = function(config)
    -- Debounce not needed anymore :) (fixed that with `:set signcolumn=yes`
    -- config.update_debounce = 5 -- ms to update (this is the cause for wierd indentation jumping)
    --   return config
    -- end,

    ["neo-tree"] = function(config)
      config.filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            ".git",
          },
          -- never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --   ".git",
          -- },
        },

        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        window = { mappings = { h = "toggle_hidden" } },
      } -- ms to update (this is the cause for wierd indentation jumping)
      return config
    end,

    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

      config.sources = {
        -- do not install anything with mason
        -- use npm instead:
        -- npm install -g typescript-language-server typescript @tailwindcss/language-server eslint_d @fsouza/prettierd markdownlint
        -- if lsp not works for autocmolpete install typescript-language-server and @tailwindcss/language-server through :LspInstall

        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.shellcheck.with({
        --   diagnostic_config = {
        --     -- see :help vim.diagnostic.config()
        --     underline = true,
        --     virtual_text = false,
        --     signs = true,
        --     update_in_insert = false,
        --     severity_sort = true,
        --   },
        -- }),

        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.markdownlint.with {
          extra_args = {
            "--disable",
            "MD040",
            "MD046",
          },
        },
        -- null_ls.builtins.formatting.prettierd.with({
        --   -- extra_args = { "--tab-width", 2, "--print-width", 20 }
        -- }),

        null_ls.builtins.code_actions.eslint_d, -- changes let to const for example
        null_ls.builtins.formatting.eslint_d, -- i think this is used only with eslint/prettier plugin

        null_ls.builtins.diagnostics.eslint_d.with {
          -- diagnostics_format = '[eslint] #{m}\n(#{c})',
          diagnostic_config = {
            -- see :help vim.diagnostic.config()
            underline = true,
            virtual_text = false, -- inline diagnostics
            signs = true,
            update_in_insert = true,
            severity_sort = true,
          },
        },

        null_ls.builtins.formatting.prettierd.with {
          -- env = {
          --   PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
          -- },
        },
        null_ls.builtins.formatting.stylua, -- can be installed by brew (or look at https://github.com/JohnnyMorganz/StyLua for other install methods)
      }

      return config -- return final config table
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      ensure_installed = {
        "lua",
        "tsx",
        "typescript",
        "javascript",
        "astro",
        "prisma",
      },
      -- indent = { enable = true },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = {
        "astro",
        -- "cssls",
        -- "emmet_ls",
        -- "html",
        -- "jsonls",
        "prismals",
        -- "sumneko_lua", -- or use luacheck + stylua together
        "tailwindcss",
        "tsserver",
      },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      ensure_installed = {
        "luacheck",
        "stylua",
        "markdownlint",
        "prettierd",
        "eslint_d",
      },
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
    -- Configure luasnip loaders (vscode, lua, and/or snipmate)
    vscode = {
      -- Add paths for including more VS Code style snippets in luasnip
      paths = {},
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
