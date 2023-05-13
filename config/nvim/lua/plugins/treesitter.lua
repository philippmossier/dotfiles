return {
  -- { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  --
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.autotag = {
        enable = true,
      }
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(
          opts.ensure_installed,
          -- extends from: https://github.com/LazyVim/LazyVim/blob/25d37a2cdd6202f1d767595454a7f84f77bbd83e/lua/lazyvim/plugins/treesitter.lua#L38
          { "go", "astro", "gitignore", "sql", "graphql", "yaml", "rust", "prisma" }
        )
      end
    end,
  },

  {
    "mfussenegger/nvim-treehopper",
    keys = { { "m", mode = { "o", "x" } } },
    config = function()
      vim.cmd([[
        omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
        xnoremap <silent> m :lua require('tsht').nodes()<CR>
      ]])
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },
}
