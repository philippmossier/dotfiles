-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell") -- remove the autocmd that enables it anyway when you enter any "text" scope (https://www.reddit.com/r/neovim/comments/1gl5uaz/snacksnvim_a_collection_of_small_qol_plugins_for/)