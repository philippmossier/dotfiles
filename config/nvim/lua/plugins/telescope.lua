return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add grep(cwd) from <leader>sG also to <leader>F
      { "<leader>F", require("lazyvim.util").telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },
}
