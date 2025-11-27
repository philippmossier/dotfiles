local utilities = require("utilities")
local map = vim.keymap.set
local is_vscode = vim.g.vscode == 1

---------------------------------------------------------------------
--  🔌 SHARED KEYMAPS (apply to both Neovim + VSCode Neovim)
---------------------------------------------------------------------

-- Yanky
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
map("n", "<C-p>", "<Plug>(YankyPreviousEntry)")
map("n", "<C-n>", "<Plug>(YankyNextEntry)")

---------------------------------------------------------------------
--  🟦 VSCODE NEOVIM CONFIG
--  This block executes ONLY when running inside VSCode
---------------------------------------------------------------------
if is_vscode then
  -------------------------------------------------------------------
  --  CHANGE-WITHOUT-YANK behavior
  -------------------------------------------------------------------
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
  --  VSCODE ADVANCED COMMANDS (LEFT HERE FOR REFERENCE ONLY)
  --  THESE ARE DISABLED BECAUSE THEY CAUSE UNDO/REDO OR SCROLL ISSUES
  ---------------------------------------------------------------------
  -------------------------------------------------------------------
  --  CURSOR & NAVIGATION
  -------------------------------------------------------------------
  -- map("n", "n", "nzzzv", { silent = true })
  -- map("n", "N", "Nzzzv", { silent = true })

  -- map("n", "<C-a>", "gg<S-v>G")   -- select all

  -- map("n", "<C-d>", "<C-d>zz")
  -- map("n", "<C-u>", "<C-u>zz")

  -------------------------------------------------------------------
  --  VSCODE COMMANDS (vscode-neovim API)
  -------------------------------------------------------------------
  -- local VS = require("vscode-neovim")

  -- map("n", "<leader>q", function()
  --   VS.call("workbench.action.closeActiveEditor")
  -- end)

  -- map("n", "<leader>s", function()
  --   VS.call("workbench.action.splitEditorRight")
  -- end)

  -- map("n", "<leader>e", function()
  --   VS.call("workbench.action.toggleSidebarVisibility")
  -- end)

  -- -- Insert-mode find
  -- map("i", "<C-f>", function()
  --   VS.call("actions.find")
  -- end)

  -- https://github.com/LazyVim/LazyVim/pull/5957
  -- https://github.com/LazyVim/LazyVim/commit/706ec4443a33ec474f2329b5b806e9cdb85cce43
  -- Undo/redo - DO NOT USE - probably crashes vscode
  -- map("n", "u", function() VS.call("undo") end)
  -- map("n", "<C-r>", function() VS.call("redo") end)

  return  -- 🚪 EXIT HERE: no native-Neovim mappings load
end



---------------------------------------------------------------------
--  🟩 NATIVE NEOVIM CONFIG
--  This block executes ONLY when running Neovim normally (terminal, nvim)
---------------------------------------------------------------------

-- Diagnostics (your 3-state toggle)
map("n", "<leader>ud", utilities.toggle_diagnostics, { desc = "Toggle Diagnostics" })

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Center cursor on movement
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Escape with jj
map("i", "jj", "<ESC>")

-- Copilot toggles
map("n", "<leader>uPd", ":Copilot disable<CR>", { desc = "copilot disable" })
map("n", "<leader>uPe", ":Copilot enable<CR>", { desc = "copilot enable" })

-------------------------------------------------------------------
--  CHANGE-WITHOUT-YANK behavior
-------------------------------------------------------------------
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

-------------------------------------------------------------------
--  TMUX / WINDOW MOVEMENT (your C-j fallback logic)
-------------------------------------------------------------------
map("n", "<C-j>", function()
  local originalWin = vim.fn.winnr()
  vim.cmd("wincmd j")

  if originalWin == vim.fn.winnr() then
    vim.fn.system("tmux select-pane -D")
  end
end, { desc = "Go to lower window or tmux pane" })

