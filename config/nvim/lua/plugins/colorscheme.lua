return {

  {
    "tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        style = "moon",
        -- transparent = true,
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
        sidebars = {
          "qf",
          "vista_kind",
          "terminal",
          "spectre_panel",
          "startuptime",
          "Outline",
        },
        on_colors = function(c)
          -- local hsluv = require("tokyonight.hsluv")
          -- local function randomColor(color)
          --   if color ~= "NONE" then
          --     local hsl = hsluv.hex_to_hsluv(color)
          --     hsl[1] = math.random(0, 360)
          --     return hsluv.hsluv_to_hex(hsl)
          --   end
          --   return color
          -- end
          -- local function set(colors)
          --   if type(colors) == "table" then
          --     for k, v in pairs(colors) do
          --       if type(v) == "string" then
          --         colors[k] = randomColor(v)
          --       elseif type(v) == "table" then
          --         set(v)
          --       end
          --     end
          --   end
          -- end
          -- set(c)
        end,
        on_highlights = function(hl, c)
          hl.CursorLineNr = { fg = c.orange, bold = true }
          hl.LineNr = { fg = c.orange, bold = true }
          hl.LineNrAbove = { fg = c.fg_gutter }
          hl.LineNrBelow = { fg = c.fg_gutter }
          local prompt = "#2d3149"
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = prompt }
          hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
          hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        end,
      }
    end,
  },

  -- { "ellisonleao/gruvbox.nvim" },

  -- { "rose-pine/neovim", name = "rose-pine" },

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   -- lazy = false,
  --   -- priority = 1000,
  --   opts = function()
  --     return {
  --       flavour = "macchiato", -- latte, frappe, macchiato, mocha
  --       background = { -- :h background
  --         light = "latte",
  --         dark = "mocha",
  --       },
  --       transparent_background = false,
  --       show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  --       term_colors = false,
  --       dim_inactive = {
  --         enabled = false,
  --         shade = "dark",
  --         percentage = 0.15,
  --       },
  --       no_italic = false, -- Force no italic
  --       no_bold = false, -- Force no bold
  --       styles = {
  --         comments = { "italic" },
  --         conditionals = { "italic" },
  --         loops = {},
  --         functions = {},
  --         keywords = {},
  --         strings = {},
  --         variables = {},
  --         numbers = {},
  --         booleans = {},
  --         properties = {},
  --         types = {},
  --         operators = {},
  --       },
  --       color_overrides = {},
  --       custom_highlights = function(colors)
  --         return {
  --           CursorLineNr = { fg = colors.peach, bold = true },
  --           LineNr = { fg = colors.peach, bold = true },
  --           LineNrBelow = { fg = colors.surface2 },
  --           LineNrAbove = { fg = colors.surface2 },
  --           -- Comment = { fg = colors.flamingo },
  --           -- ["@constant.builtin"] = { fg = colors.peach, style = {} },
  --           -- ["@comment"] = { fg = colors.surface2, style = { "italic" } },
  --         }
  --       end,
  --       integrations = {
  --         cmp = true,
  --         gitsigns = true,
  --         nvimtree = true,
  --         telescope = true,
  --         notify = false,
  --         mini = false,
  --         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  --       },
  --     }
  --   end,
  -- },
}
