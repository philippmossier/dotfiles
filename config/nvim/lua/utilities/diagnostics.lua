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


-- local M = {}

-- ---------------------------------------------------------------------
-- -- DETECT ALL DIAGNOSTIC SIGNS AUTOMATICALLY
-- ---------------------------------------------------------------------
-- local function get_diagnostic_signs()
--   local all = vim.fn.sign_getdefined()
--   local diag = {}

--   for _, sign in ipairs(all) do
--     if sign.name:match("Diagnostic") then
--       -- Example name: DiagnosticSignError or DiagnosticError
--       local severity = sign.name:match("DiagnosticSign(%a+)")
--         or sign.name:match("Diagnostic(%a+)")

--       if severity and sign.text then
--         diag[severity] = {
--           name = sign.name,
--           text = sign.text,
--           texthl = sign.texthl,
--         }
--       end
--     end
--   end

--   return diag
-- end

-- local DiagnosticSigns = get_diagnostic_signs()

-- local function restore_signs()
--   for severity, sign in pairs(DiagnosticSigns) do
--     vim.fn.sign_define(sign.name, {
--       text = sign.text,
--       texthl = sign.texthl,
--       numhl = sign.numhl,
--     })
--   end
-- end

-- ---------------------------------------------------------------------
-- -- 3-state toggle
-- ---------------------------------------------------------------------
-- local state = 1

-- function M.toggle_diagnostics()
--   if state == 1 then
--     -- → state 2
--     state = 2
--     vim.diagnostic.config({
--       virtual_text = false,
--       underline = true,
--       signs = true,
--     })
--     restore_signs()
--     Snacks.notify("Diagnostics: no virtual text", { title = "Diagnostics" })

--   elseif state == 2 then
--     -- → state 3
--     state = 3
--     vim.diagnostic.config({
--       virtual_text = false,
--       underline = false,
--       signs = false,
--     })
--     Snacks.notify("Diagnostics: disabled", { title = "Diagnostics" })

--   else
--     -- → state 1
--     state = 1
--     vim.diagnostic.config({
--       virtual_text = true,
--       underline = true,
--       signs = true,
--     })
--     restore_signs()
--     Snacks.notify("Diagnostics: enabled", { title = "Diagnostics" })
--   end
-- end

-- return M


-- local M = {}

-- ---------------------------------------------------------------------
-- -- 1. Capture the real sign definitions from Neovim at startup.
-- --    This reads the actual icons (, , , etc.) LazyVim configured.
-- ---------------------------------------------------------------------
-- local function capture_sign(name)
--   local signs = vim.fn.sign_getdefined(name)
--   return signs[1] or {}
-- end

-- local DiagnosticSigns = {
--   Error = capture_sign("DiagnosticSignError"),
--   Warn  = capture_sign("DiagnosticSignWarn"),
--   Hint  = capture_sign("DiagnosticSignHint"),
--   Info  = capture_sign("DiagnosticSignInfo"),
-- }

-- ---------------------------------------------------------------------
-- -- 2. Restore the icons (using sign_define)
-- ---------------------------------------------------------------------
-- local function restore_signs()
--   for severity, sign in pairs(DiagnosticSigns) do
--     if sign and sign.text then
--       vim.fn.sign_define("DiagnosticSign" .. severity, sign)
--     end
--   end
-- end

-- ---------------------------------------------------------------------
-- -- 3. Toggle states
-- --    1 = full diagnostics
-- --    2 = no virtual text (signs + underline only)
-- --    3 = diagnostics off
-- ---------------------------------------------------------------------
-- local state = 1

-- function M.toggle_diagnostics()
--   if state == 1 then
--     -- → STATE 2
--     state = 2
--     vim.diagnostic.config({
--       virtual_text = false,
--       underline = true,
--       signs = true,  -- but icons will be restored next line
--     })
--     restore_signs()
--     Snacks.notify("Diagnostics: no virtual text", { level = "info", title = "Diagnostics" })

--   elseif state == 2 then
--     -- → STATE 3
--     state = 3
--     vim.diagnostic.config({
--       virtual_text = false,
--       underline = false,
--       signs = false,
--     })
--     Snacks.notify("Diagnostics: fully disabled", { level = "warn", title = "Diagnostics" })

--   else
--     -- → STATE 1
--     state = 1
--     vim.diagnostic.config({
--       virtual_text = true,
--       underline = true,
--       signs = true, -- re-enable sign column
--     })
--     restore_signs() -- reapply the icon glyphs
--     Snacks.notify("Diagnostics: fully enabled", { level = "info", title = "Diagnostics" })
--   end
-- end

-- return M


-- local M = {}

-- ---------------------------------------------------------------------
-- -- Capture LazyVim's diagnostic sign icons ONCE.
-- -- This is the only reliable way to prevent fallback icons (E/W/H/I).
-- ---------------------------------------------------------------------
-- local default_signs = vim.deepcopy(vim.diagnostic.config().signs)

-- -- State machine:
-- --   1 = full diagnostics
-- --   2 = no virtual text
-- --   3 = diagnostics off
-- local state = 1

-- function M.toggle_diagnostics()
--   if state == 1 then
--     -------------------------------------------------------------------
--     -- STATE 2: keep signs + underline, disable virtual text
--     -------------------------------------------------------------------
--     state = 2
--     vim.diagnostic.config({
--       virtual_text = false,
--       underline    = true,
--       signs        = default_signs, -- restore preserved icons
--     })

--     Snacks.notify("Diagnostics: no virtual text", {
--       level = "info",
--       title = "Diagnostics",
--     })

--   elseif state == 2 then
--     -------------------------------------------------------------------
--     -- STATE 3: disable everything
--     -------------------------------------------------------------------
--     state = 3
--     vim.diagnostic.config({
--       virtual_text = false,
--       underline    = false,
--       signs        = false,
--     })

--     Snacks.notify("Diagnostics: fully disabled", {
--       level = "warn",
--       title = "Diagnostics",
--     })

--   else
--     -------------------------------------------------------------------
--     -- STATE 1: restore full diagnostics (with proper icons)
--     -------------------------------------------------------------------
--     state = 1
--     vim.diagnostic.config({
--       virtual_text = true,
--       underline    = true,
--       signs        = default_signs, -- critical!!! restore icons
--     })

--     Snacks.notify("Diagnostics: fully enabled", {
--       level = "info",
--       title = "Diagnostics",
--     })
--   end
-- end

-- return M


-- local M = {}

-- -- 1: full diagnostics
-- -- 2: no virtual text
-- -- 3: all off
-- local state = 1

-- function M.toggle_diagnostics()
--   if state == 1 then
--     ---------------------------------------------------------
--     -- STATE 2: No virtual text (preserves icons)
--     ---------------------------------------------------------
--     state = 2
--     vim.diagnostic.config({
--       virtual_text = false,
--       underline = true,
--       -- IMPORTANT:
--       -- Do NOT set signs=true, leave it untouched
--       -- or icons get replaced with E/W/H/I
--     })

--     Snacks.notify("Diagnostics: no virtual text", {
--       level = "info",
--       title = "Diagnostics",
--     })

--   elseif state == 2 then
--     ---------------------------------------------------------
--     -- STATE 3: Everything off
--     ---------------------------------------------------------
--     state = 3
--     vim.diagnostic.config({
--       virtual_text = false,
--       signs = false,
--       underline = false,
--     })

--     Snacks.notify("Diagnostics: fully disabled", {
--       level = "warn",
--       title = "Diagnostics",
--     })

--   else
--     ---------------------------------------------------------
--     -- STATE 1: Full diagnostics (icons preserved)
--     ---------------------------------------------------------
--     state = 1
--     vim.diagnostic.config({
--       virtual_text = true,
--       underline = true,
--       signs = true,  -- ← THIS WOULD BREAK ICONS! :)
--       -- Instead:
--       -- signs = nil   (or just omit)
--     })

--     vim.diagnostic.config({ signs = true }) -- enable signs without replacing icons

--     Snacks.notify("Diagnostics: fully enabled", {
--       level = "info",
--       title = "Diagnostics",
--     })
--   end
-- end

-- return M



-- works (but overvrites icons with letters)
-- local M = {}

-- -- Three states:
-- -- 1 = full diagnostics
-- -- 2 = signs + underline only
-- -- 3 = diagnostics fully hidden
-- local state = 1

-- function M.toggle_diagnostics()
--   if state == 1 then
--     -- Move → state 2
--     state = 2
--     vim.diagnostic.config({
--       virtual_text = false,
--       signs = true,
--       underline = true,
--     })
--     Snacks.notify("Diagnostics: no virtual text", {
--       level = "info",
--       title = "Diagnostics",
--     })

--   elseif state == 2 then
--     -- Move → state 3
--     state = 3
--     vim.diagnostic.config({
--       virtual_text = false,
--       signs = false,
--       underline = false,
--     })
--     Snacks.notify("Diagnostics: fully disabled", {
--       level = "warn",
--       title = "Diagnostics",
--     })

--   else
--     -- Move → state 1
--     state = 1
--     vim.diagnostic.config({
--       virtual_text = true,
--       signs = true,
--       underline = true,
--     })
--     Snacks.notify("Diagnostics: fully enabled", {
--       level = "info",
--       title = "Diagnostics",
--     })
--   end
-- end

-- return M



-- NEW 2 states version (show all, signs+underline only)
-- local M = {}

-- function M.toggle_diagnostics()
--   -- Get current state from Neovim, not from a local variable
--   local current = vim.diagnostic.config().virtual_text

--   -- Normalize: virtual_text may be `false` or a table
--   local enabled = current ~= false

--   -- Toggle
--   local new = not enabled

--   vim.diagnostic.config({
--     virtual_text = new,
--   })

--   if new then
--     Snacks.notify("Diagnostics virtual text enabled", {
--       level = "info",
--       title = "Diagnostics",
--     })
--   else
--     Snacks.notify("Diagnostics virtual text disabled", {
--       level = "warn",
--       title = "Diagnostics",
--     })
--   end
-- end

-- return M


-- OLD VERSION (still works)
-- local Util = require("lazyvim.util")
-- local M = {}

-- local enabled = true

-- function M.toggle_diagnostics()
--   enabled = not enabled
--   if enabled then
--     vim.diagnostic.config({
--       underline = true,
--       virtual_text = {
--         spacing = 4,
--         source = "if_many",
--         prefix = "●",
--         -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
--         -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
--         -- prefix = "icons",
--       },
--       severity_sort = true,
--       update_in_insert = false,

--       signs = {
--         text = {
--           [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Hint,
--           [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
--           [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
--           [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
--         },
--       },
--     })

--     Util.info("Enabled virtual text", { title = "Diagnostics" })
--   else
--     vim.diagnostic.config({
--       underline = true,
--       virtual_text = false,
--       severity_sort = true,
--       update_in_insert = false,
--       signs = {
--         text = {
--           [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
--           [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
--           [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
--           [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
--         },
--       },
--     })
--     Util.warn("Disabled virtual text", { title = "Diagnostics" })
--   end
-- end

-- return M
