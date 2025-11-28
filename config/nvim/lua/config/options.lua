-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.g.snacks_animate = false

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99  -- open everything by default


---------------------------------------------------------------------------
-- ESLint / Prettier Integration Notes
--
-- We enable only the ESLint LazyExtra for diagnostics + code actions.
-- DO NOT enable the Prettier LazyExtra:
--   - It adds the slow "prettier" binary (not prettierd)
--   - It overrides Conform formatters
--   - It conflicts with our custom prettierd setup
--
-- PrettierD (prettierd) is installed via Mason and used through Conform
-- for JS/TS/React/Tailwind/HTML/CSS/etc. formatting.
--
-- ESLint LSP:
--   - Provides diagnostics and code actions
--   - "Fix all fixable ESLint issues" works manually (<leader>ca)
--   - Auto-format/fixAll on save is disabled:
--       vim.g.lazyvim_eslint_auto_format = false
--   - Formatting is handled by prettierd exclusively.
---------------------------------------------------------------------------

-- Disable ESLint auto-format (we use prettierd via Conform instead)
vim.g.lazyvim_eslint_auto_format = false
