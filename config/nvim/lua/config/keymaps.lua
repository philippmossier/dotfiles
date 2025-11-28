-- Default lazyvim keybindings: https://raw.githubusercontent.com/LazyVim/LazyVim/refs/heads/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

---------------------------------------------------------------------
-- 🔌 SHARED KEYMAPS (apply to both Neovim + VSCode Neovim)
---------------------------------------------------------------------

-- Yanky
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
map("n", "<C-p>", "<Plug>(YankyPreviousEntry)")
map("n", "<C-n>", "<Plug>(YankyNextEntry)")

-- Change without yanking
map("v", "p", '"_dP')
map("n", "ciw", '"_ciw')
map("n", "ci[", '"_ci[')
map("n", "ci]", '"_ci]')
map("n", "cit", '"_cit')
map("n", "ci(", '"_ci(')
map("n", "ci)", '"_ci)')
map("n", "ci'", "\"_ci'")
map("n", 'ci"', '"_ci"')
map("n", "ci{", '"_ci{')
map("n", "ci}", '"_ci}')

---------------------------------------------------------------------
-- 🟦 VSCode Neovim CONFIG
-- Loaded ONLY when running inside VSCode
---------------------------------------------------------------------
if vim.g.vscode then
  return
end

---------------------------------------------------------------------
-- 🟩 NATIVE NEOVIM CONFIG (Terminal Neovim only)
---------------------------------------------------------------------

local utilities = require("utilities")

map("n", "<leader>fN", function()
  require("snacks").scratch()
end, { desc = "New Snacks Scratch Buffer" })

-- Diagnostics toggle
map("n", "<leader>ud", utilities.toggle_diagnostics)

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Cursor centering
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Insert mode escape
map("i", "jj", "<ESC>")

-- Copilot toggles
map("n", "<leader>uPd", ":Copilot disable<CR>")
map("n", "<leader>uPe", ":Copilot enable<CR>")

-- Tmux / window movement fallback
map("n", "<C-j>", function()
  local originalWin = vim.fn.winnr()
  vim.cmd("wincmd j")
  if originalWin == vim.fn.winnr() then
    vim.fn.system("tmux select-pane -D")
  end
end, { desc = "Go to lower window or tmux pane" })
