-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
if vim.g.vscode then return end
local utilities = require("utilities")

-- If neovim runs inside vscode:
if vim.g.vscode then
  vim.keymap.set(
    "n",
    "<leader>q",
    "<Cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<CR>",
    { noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<Leader>s",
    "<Cmd>lua require('vscode-neovim').call('workbench.action.splitEditorRight')<CR>",
    { noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<Leader>e",
    "<Cmd>lua require('vscode-neovim').call('workbench.action.toggleSidebarVisibility')<CR>",
    { noremap = true, silent = true }
  )

  vim.keymap.set(
    "i",
    "<C-f>",
    "<Cmd>lua require('vscode-neovim').call('actions.find')<CR>",
    { noremap = true, silent = true }
  )
  vim.keymap.set("n", "u", "<Cmd>lua require('vscode-neovim').call('undo')<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "<C-r>", "<Cmd>lua require('vscode-neovim').call('redo')<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "<C-a>", "gg<S-v>G", { noremap = true, silent = true })

  vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
  vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
  vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
  vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

  vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })
  vim.keymap.set("n", "ciw", '"_ciw', { noremap = true, silent = true })
  vim.keymap.set("n", "ci[", '"_ci[', { noremap = true, silent = true })
  vim.keymap.set("n", "ci]", '"_ci]', { noremap = true, silent = true })
  vim.keymap.set("n", "cit", '"_cit', { noremap = true, silent = true })
  vim.keymap.set("n", "ci(", '"_ci(', { noremap = true, silent = true })
  vim.keymap.set("n", "ci)", '"_ci)', { noremap = true, silent = true })
  vim.keymap.set("n", "ci'", "\"_ci'", { noremap = true, silent = true })
  vim.keymap.set("n", "ci{", '"_ci{', { noremap = true, silent = true })
  vim.keymap.set("n", "ci}", '"_ci}', { noremap = true, silent = true })

  -- ============ Some of thes following do not work inside vscode (at least on mac) ==================
  -- vim.keymap.set(
  --   "n",
  --   "<S-h>",
  --   "<Cmd>lua require('vscode-neovim').call('workbench.action.previousEditor')<CR>",
  --   { noremap = true, silent = true }
  -- )
  -- vim.keymap.set(
  --   "n",
  --   "<S-l>",
  --   "<Cmd>lua require('vscode-neovim').call('workbench.action.nextEditor')<CR>",
  --   { noremap = true, silent = true }
  -- )

  -- vim.keymap.set("n", "<C-z>", "<Cmd>lua require('vscode-neovim').call('undo')<CR>", { noremap = true, silent = true })
  -- vim.keymap.set(
  --   "n",
  --   "<C-S-z>",
  --   "<Cmd>lua require('vscode-neovim').call('redo')<CR>",
  --   { noremap = true, silent = true }
  -- )
  -- vim.keymap.set(
  -- 	"n",
  -- 	"<C-a>",
  -- 	"<Cmd>lua require('vscode-neovim').call('editor.action.selectAll')<CR>",
  -- 	{ noremap = true, silent = true }
  -- )
  -- vim.keymap.set(
  --   "n",
  --   "<C-f>",
  --   "<Cmd>lua require('vscode-neovim').call('actions.find')<CR>",
  --   { noremap = true, silent = true }
  -- )

  -- vim.keymap.set(
  --   "i",
  --   "<C-d>",
  --   "<Cmd>lua require('vscode-neovim').call('editor.action.addSelectionToNextFindMatch')<CR>",
  --   { noremap = true, silent = true }
  -- )
  -- vim.keymap.set(
  --   "i",
  --   "<C-a>",
  --   "<Cmd>lua require('vscode-neovim').call('editor.action.selectAll')<CR>",
  --   { noremap = true, silent = true }
  -- )
  -- vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })
else
  local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys

    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
      opts = opts or {}
      opts.silent = opts.silent ~= false
      if opts.remap and not vim.g.vscode then
        opts.remap = nil
      end
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end

  -- select all
  map("n", "<C-a>", "gg<S-v>G")

  -- Keeps cursor at the middle of the screen when jupping top and bottom
  map("n", "<C-d>", "<C-d>zz")
  map("n", "<C-u>", "<C-u>zz")

  -- Keeps cursor at the middle while searching
  map("n", "n", "nzzzv")
  map("n", "N", "Nzzzv")

  -- use jj to exit insert mode
  map("i", "jj", "<ESC>")

  -- copilot
  map("n", "<leader>uPd", ":Copilot disable<cr>", { desc = "copilot disable" })
  map("n", "<leader>uPe", ":Copilot enable<cr>", { desc = "copilot enable" })

  -- overwrite default lazyvim diagnostics toggler:
  map("n", "<leader>ud", utilities.toggle_diagnostics, { desc = "Toggle Diagnostics" })

  -- ==== Clipboard overwrite behavior ====
  map("v", "p", '"_dP', { desc = "viewmode-paste without clipboard overwrite" }) --  // description at 11:46 (https://www.youtube.com/watch?v=435-amtVYJ8&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ&index=3)
  map("n", "ciw", '"_ciw', { desc = "Change inside word without affecting the clipboard" })
  map("n", "ci[", '"_ci[', { desc = "Change inside word without affecting the clipboard" })
  map("n", "ci]", '"_ci]', { desc = "Change inside word without affecting the clipboard" })
  map("n", "cit", '"_cit', { desc = "Change inside word without affecting the clipboard" })
  map("n", "ci(", '"_ci(', { desc = "Change inside word without affecting the clipboard" })
  map("n", "ci)", '"_ci)', { desc = "Change inside word without affecting the clipboard" })
  map("n", "ci'", "\"_ci'", { desc = "Change inside word without affecting the clipboard" })
  map("n", 'ci"', '"_ci"', { desc = "Change inside word without affecting the clipboard" })
  map("n", "ci{", '"_ci{', { desc = "Change inside word without affecting the clipboard" })
  map("n", "ci}", '"_ci}', { desc = "Change inside word without affecting the clipboard" })
  -- map("n", "diw", '"_diw', { desc = "Delete inside word without affecting the clipboard" })
end
