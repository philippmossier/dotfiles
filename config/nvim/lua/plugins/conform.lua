-- Conform formatting setup.
-- This file ensures prettierd is used as the ONLY formatter for JS/TS/React.
--
-- IMPORTANT:
--   - The LazyVim "formatting.prettier" extra must NOT be enabled.
--     It adds slow 'prettier' and conflicts with prettierd.
--
--   - PrettierD (prettierd) must be installed via Mason:
--       :Mason -> install `prettierd`
--
--   - ESLint LazyExtra SHOULD be enabled, but with:
--       vim.g.lazyvim_eslint_auto_format = false
--     This gives ESLint diagnostics + code actions WITHOUT running fixAll on save.
--
--   - vtsls (from the typescript extra) still provides TS IntelliSense, but all
--     LSP formatting for TS/JS is disabled here so there are no conflicts.
--
--   - LSP formatting fallback is disabled ONLY for JS/TS filetypes.
--     Other languages (Go, Rust, Python, etc.) still use LSP formatting normally.
--
-- Result:
--   ✓ Fast formatting (prettierd)
--   ✓ No ESLint/TS LSP formatting
--   ✓ No ESLint fixAll slowdowns
--   ✓ ESLint code actions still work ("Fix all fixable issues")
--   ✓ Formatting identical to VSCode Prettier
--   ✓ Zero conflicts, optimal performance
--

return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    ---------------------------------------------------------------------------
    -- Per-filetype LSP fallback:
    -- Disable LSP formatting for JavaScript / TypeScript variants.
    -- This prevents vtsls or eslint from formatting.
    -- Other languages may still use LSP formatting.
    ---------------------------------------------------------------------------
    opts.lsp_fallback = function(ctx)
      if vim.tbl_contains({
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      }, ctx.filetype) then
        return false -- Use ONLY prettierd for formatting
      end
      return true -- Allow LSP formatting for other languages
    end

    ---------------------------------------------------------------------------
    -- Formatter assignments:
    -- PrettierD for JS/TS/React/etc.
    -- All other non-conflicting formatters remain untouched.
    ---------------------------------------------------------------------------
    opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      vue = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
    })

    return opts
  end,
}
