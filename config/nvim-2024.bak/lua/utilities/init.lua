local Util = require("lazyvim.util")
local M = {}

local enabled = true

function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.config({
      underline = true,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
      update_in_insert = false,

      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Hint,
          [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
        },
      },
    })

    Util.info("Enabled virtual text", { title = "Diagnostics" })
  else
    vim.diagnostic.config({
      underline = true,
      virtual_text = false,
      severity_sort = true,
      update_in_insert = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
        },
      },
    })
    Util.warn("Disabled virtual text", { title = "Diagnostics" })
  end
end

return M
