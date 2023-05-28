-- if true then return {} end
return {

  -- inlay hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim", "mfussenegger/nvim-jdtls" },
    -- add folding range to capabilities
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,

        -- DISABLE inline diagnostics:
        -- you can show line diagnostics with <leader>cd (while hovering)
        -- or use <leader>xx to show a list of file diagnostics in a seperate window (you can close the window with <leader>xx aswell)
        virtual_text = true,

        -- DEFAULT lazyvim config:
        -- virtual_text = {
        --   spacing = 4,
        --   source = "if_many",
        --   prefix = "●",
        --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        --   -- prefix = "icons",
        -- },
      },
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      -- make sure mason installs the server
      servers = {
        astro = {},
        bashls = {},
        clangd = {},
        -- denols = {},
        marksman = {},
        cssls = {},
        dockerls = {},
        ruff_lsp = {},
        svelte = {},
        html = {},
        gopls = {},
        pyright = {},
        prismals = {},
        -- tailwindcss = {
        --   settings = {
        --     tailwindCss = {
        --       experimental = {
        --         -- configFile = vim.fn.stdpath("config") .. "/tailwind/index.ts",
        --         -- configFile = "packages/config/tailwind/index.ts",
        --         -- configFile = "/tailwind/index.ts",
        --         -- configFile = "/Users/phil/twurbonpm/packages/config/tailwind/index.ts"
        --         configFile = "/Users/phil/twtest/tailwind.config.ts"
        --       },
        --     }
        --   },
        --   default_config = { root_dir = "/Users/phil/twtest/tailwind.config.ts" }
        -- },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  "--log-level=trace",
                },
              },
              diagnostics = {
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        -- ======= TS ========
        ---@type lspconfig.options.tsserver
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        -- ======= ESLINT ========
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectory = { mode = "auto" },
          },
        },
      },
      setup = {
        -- ======= TS ========
        tsserver = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "tsserver" then
              -- stylua: ignore
              vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>",
                { buffer = buffer, desc = "Organize Imports" })
              -- stylua: ignore
              vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>",
                { desc = "Rename File", buffer = buffer })
            end
          end)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- ======= ESLINT ========
        eslint = function()
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(event)
              if require("lspconfig.util").get_active_client_by_name(event.buf, "eslint") then
                vim.cmd("EslintFixAll")
              end
            end,
          })
        end,
        -- ======= JAVA ========
        jdtls = function(_, opts)
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              require("lazyvim.util").on_attach(function(_, buffer)
                vim.keymap.set(
                  "n",
                  "<leader>di",
                  "<Cmd>lua require'jdtls'.organize_imports()<CR>",
                  { buffer = buffer, desc = "Organize Imports" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>dt",
                  "<Cmd>lua require'jdtls'.test_class()<CR>",
                  { buffer = buffer, desc = "Test Class" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>dn",
                  "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
                  { buffer = buffer, desc = "Test Nearest Method" }
                )
                vim.keymap.set(
                  "v",
                  "<leader>de",
                  "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
                  { buffer = buffer, desc = "Extract Variable" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>de",
                  "<Cmd>lua require('jdtls').extract_variable()<CR>",
                  { buffer = buffer, desc = "Extract Variable" }
                )
                vim.keymap.set(
                  "v",
                  "<leader>dm",
                  "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
                  { buffer = buffer, desc = "Extract Method" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>cf",
                  "<cmd>lua vim.lsp.buf.formatting()<CR>",
                  { buffer = buffer, desc = "Format" }
                )
              end)

              local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
              -- vim.lsp.set_log_level('DEBUG')
              local workspace_dir = "/Users/phil/.local/share/nvim/jdtls_lsp_workspaces/" .. project_name -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
              local config = {
                -- The command that starts the language server
                -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                cmd = {
                  -- '/path/to/java17_or_newer/bin/java'
                  "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java",
                  -- depends on if `java` is in your $PATH env variable and if it points to:workspace the right version.

                  -- -Declipse.application=org.eclipse.jdt.ls.core.id1 \
                  -- -Dosgi.bundles.defaultStartLevel=4 \
                  -- -Declipse.product=org.eclipse.jdt.ls.core.product \
                  -- -Dlog.level=ALL \
                  -- -Xmx1G \
                  -- --add-modules=ALL-SYSTEM \
                  -- --add-opens java.base/java.util=ALL-UNNAMED \
                  -- --add-opens java.base/java.lang=ALL-UNNAMED \
                  -- -jar ./plugins/org.eclipse.equinox.launcher_1.5.200.v20180922-1751.jar \
                  -- -configuration ./config_linux \
                  -- -data /path/to/data

                  -- '-Xbootclasspath/a:/home/jake/.local/share/java/lombok.jar',
                  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                  "-Dosgi.bundles.defaultStartLevel=4",
                  "-Declipse.product=org.eclipse.jdt.ls.core.product",
                  "-Dlog.protocol=true",
                  "-Dlog.level=ALL",
                  -- '-noverify',
                  "-Xms1g",
                  "--add-modules=ALL-SYSTEM",
                  "--add-opens",
                  "java.base/java.util=ALL-UNNAMED",
                  "--add-opens",
                  "java.base/java.lang=ALL-UNNAMED",
                  "-jar",
                  vim.fn.glob(
                    "/Users/phil/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
                  ),
                  -- vim.fn.glob("/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
                  -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
                  -- Must point to the                                                     Change this to
                  -- eclipse.jdt.ls installation                                           the actual version

                  "-configuration",
                  "/Users/phil/.local/share/nvim/mason/packages/jdtls/config_mac",
                  -- "/usr/share/java/jdtls/config_linux",
                  -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                  -- Must point to the                      Change to one of `linux`, `win` or `mac`
                  -- eclipse.jdt.ls installation            Depending on your system.

                  -- See `data directory configuration` section in the README
                  "-data",
                  workspace_dir,
                },
                -- This is the default if not provided, you can remove it. Or adjust as needed.
                -- One dedicated LSP server & client will be started per unique root_dir
                -- root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
                root_dir = require("jdtls.setup").find_root({ ".git" }),
                -- Here you can configure eclipse.jdt.ls specific settings
                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                -- for a list of options
                settings = {
                  java = {},
                },
                handlers = {
                  ["language/status"] = function(_, result)
                    -- print(result)
                  end,
                  ["$/progress"] = function(_, result, ctx)
                    -- disable progress updates.
                  end,
                },
              }
              require("jdtls").start_or_attach(config)
            end,
          })
          return true
        end,
      },
    },
  },
}
