local M = {}

-- 1 = full diagnostics
-- 2 = signs+underline only
-- 3 = all diagnostics disabled
local state = 1

-- Load LazyVim's icon set (always valid)
local lv_icons = require("lazyvim.config").icons.diagnostics

-- Convert LazyVim icon map into severity-indexed table
local signs_table = {
  text = {
    [vim.diagnostic.severity.ERROR] = lv_icons.Error,
    [vim.diagnostic.severity.WARN]  = lv_icons.Warn,
    [vim.diagnostic.severity.HINT]  = lv_icons.Hint,
    [vim.diagnostic.severity.INFO]  = lv_icons.Info,
  },
}

-- Restore diagnostic signs without replacing original icons
local function restore_signs()
  for severity, icon in pairs(signs_table.text) do
    local name = ({
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
    })[severity]

    vim.fn.sign_define(name, {
      text = icon,
      texthl = name,
      numhl = name,
    })
  end
end

function M.toggle_diagnostics()
  if state == 1 then
    ------------------------------------------------------
    -- STATE 2: disable virtual text (preserve icons)
    ------------------------------------------------------
    state = 2

    vim.diagnostic.config({
      virtual_text = false,
      underline = true,
      -- DO NOT set signs=true or signs={}; that breaks icons
    })

    restore_signs()

    Snacks.notify("Diagnostics: no virtual text", {
      title = "Diagnostics",
      level = "info",
    })

  elseif state == 2 then
    ------------------------------------------------------
    -- STATE 3: disable everything
    ------------------------------------------------------
    state = 3

    vim.diagnostic.config({
      virtual_text = false,
      underline = false,
      signs = false,
    })

    Snacks.notify("Diagnostics: disabled", {
      title = "Diagnostics",
      level = "warn",
    })

  else
    ------------------------------------------------------
    -- STATE 1: full diagnostics
    ------------------------------------------------------
    state = 1

    vim.diagnostic.config({
      virtual_text = true,
      underline = true,
      signs = true, -- resets built-in signs, so…
    })

    restore_signs() -- …reapply correct LazyVim icons

    Snacks.notify("Diagnostics: enabled", {
      title = "Diagnostics",
      level = "info",
    })
  end
end

return M