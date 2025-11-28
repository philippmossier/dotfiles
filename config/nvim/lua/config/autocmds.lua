-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- we disabled spellcheck in plugins/snacks.lua via `spell = { enabled = false }` but we also have to remove the following autocmd to make the spellcheck disable work
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell") -- remove the autocmd that enables it anyway when you enter any "text" scope (https://www.reddit.com/r/neovim/comments/1gl5uaz/snacksnvim_a_collection_of_small_qol_plugins_for/)

-- Disable conceal only in Markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 0
    vim.opt_local.concealcursor = ""
  end,
})

--------------------------------------------------------------------------------
-- Smart Write (Unnamed File Save Prompt)
--
-- Problem:
--   When using <leader>fn (LazyVim), you get a new unnamed buffer.
--   Running :w in that buffer produces "E32: No file name".
--
-- Goal:
--   Make :w automatically open a "Save as: " prompt *only when* the buffer
--   has no filename. If the buffer already has a name, behave like normal :w.
--
-- How it works:
--   1. Define a custom command :WriteSmart that:
--        - checks if buffer is unnamed
--        - opens vim.ui.input() to ask for a filename
--        - writes the file
--
--   2. Use a command-line abbreviation (cabbrev) so that typing :w
--      transparently expands to :WriteSmart ONLY when the command-line
--      literally contains "w".
--
-- Why cabbrev instead of overriding :w:
--   Neovim does NOT allow overriding lowercase built-in commands via
--   vim.api.nvim_create_user_command(). They MUST start with uppercase.
--   The only reliable way to intercept :w is to use a command-line abbrev.
--------------------------------------------------------------------------------

-- 1. Smart write command
vim.api.nvim_create_user_command("WriteSmart", function(opts)
  local buf = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf)

  -- If the buffer has no name → ask for filename
  if name == "" then
    vim.ui.input({ prompt = "Save as: " }, function(file)
      if file and file ~= "" then
        vim.cmd("write " .. vim.fn.fnameescape(file))
      else
        vim.notify("Save cancelled", vim.log.levels.INFO)
      end
    end)

  else
    -- Otherwise just do a normal write (:w or :w!)
    vim.cmd("write" .. (opts.bang and "!" or ""))
  end
end, { bang = true })

-- 2. Command-line abbreviation:
--    When user types ":w" (and only exactly "w"),
--    replace it with "WriteSmart".
--
--    Keeps behavior intact for:
--      :w filename
--      :w!
--      :write
--      :w >> file
--      etc.
vim.cmd([[
  cabbrev <expr> w  getcmdtype() == ':' && getcmdline() ==# 'w' ? 'WriteSmart' : 'w'
]])
