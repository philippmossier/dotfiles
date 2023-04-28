return {
  { "windwp/nvim-ts-autotag" },
  { "jose-elias-alvarez/typescript.nvim" },
  { "mfussenegger/nvim-jdtls" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.autotag = {
        enable = true,
      }
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
      table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "prettierd")
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}
