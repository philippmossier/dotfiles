local Util = require("lazy.core.util")
local M = {}

local enabled = true

function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.config({
      underline = true,
      virtual_text = true,
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
