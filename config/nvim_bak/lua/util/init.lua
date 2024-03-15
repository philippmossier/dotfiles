local Util = require("lazy.core.util")
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
    })

    Util.info("Enabled virtual text", { title = "Diagnostics" })
  else
    vim.diagnostic.config({
      underline = true,
      virtual_text = false,
      severity_sort = true,
      update_in_insert = false,
    })
    Util.warn("Disabled virtual text", { title = "Diagnostics" })
  end
end

return M
