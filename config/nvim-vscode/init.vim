echo "Config init.vim loaded successfully!"

" packadd quickscope

" execute 'luafile ' . stdpath('config') . '/lua/settings.lua'
function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
endfunction

function! s:vscodeCommentary(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    elseif a:0 > 1
        let [line1, line2] = [a:1, a:2]
    else
        let [line1, line2] = [line("'["), line("']")]
    endif

    call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
endfunction

function! s:openVSCodeCommandsInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

function! s:openWhichKeyInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

" Better Navigation
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

" Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
xnoremap <expr> <C-/> <SID>vscodeCommentary()
nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Simulate same TAB behavior in VSCode
nmap <Tab> :Tabnext<CR>
nmap <S-Tab> :Tabprev<CR>

set clipboard=unnamedplus

" =================== My config ===============================

" use vscode history stack: https://github.com/vscode-neovim/vscode-neovim/issues/1139#issuecomment-1412732566
" nmap <silent> u <Cmd>call VSCodeNotify('undo')<CR>
" nmap <silent> <C-r> <Cmd>call VSCodeNotify('redo')<CR>

function! s:undoWrapper()
    let l:before = undotree().seq_cur
    silent! undo
    let l:after = undotree().seq_cur
    if l:before == l:after
        echo "Already at oldest change, sending save commang to vscode, to get rid of dirty file status..."
        call VSCodeNotify('workbench.action.files.save')
    endif
endfunction

nnoremap u :call <SID>undoWrapper()<CR>


" Define a custom highlight group for yanked text
highlight HighlightedyankRegion cterm=reverse gui=reverse guibg=rgba(230,97,89,0.7) guifg=white

" Automatically highlight yanked text
augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="HighlightedyankRegion", timeout=120}
augroup END

" use lazy.nvim plugin manager and then load flash.nvim
" Manually set the runtime path to include lazy.nvim
set runtimepath^=/Users/phil/.local/share/nvim/lazy/lazy.nvim

" Now, you should be able to require lazy.nvim and configure plugins
lua << EOF
require('lazy').setup({
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufRead', 'BufNewFile' },  -- Changed from custom 'LazyFile', 'VeryLazy' to standard events
        init = function(plugin)
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                config = function()
                    local move = require("nvim-treesitter.textobjects.move")
                    local configs = require("nvim-treesitter.configs")
                    for name, fn in pairs(move) do
                        if name:find("goto") == 1 then
                            move[name] = function(q, ...)
                                if vim.wo.diff then
                                    local config = configs.get_module("textobjects.move")[name]
                                    for key, query in pairs(config or {}) do
                                        if q == query and key:find("[%]%[][cC]") then
                                            vim.cmd("normal! " .. key)
                                            return
                                        end
                                    end
                                end
                                return fn(q, ...)
                            end
                        end
                    end
                end
            }
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "bash", "c", "diff", "html", "javascript", "jsdoc", "json", "jsonc", "lua", "luadoc", "luap",
                    "markdown", "markdown_inline", "python", "query", "regex", "toml", "tsx", "typescript",
                    "vim", "vimdoc", "xml", "yaml"
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<C-space>',
                        node_incremental = '<C-space>',
                        scope_incremental = '<C-space>',
                        node_decremental = '<bs>',
                    },
                },
                textobjects = {
                    move = {
                        enable = true,
                        goto_next_start = {
                            [']f'] = '@function.outer',
                            [']c'] = '@class.outer'
                        },
                        goto_next_end = {
                            [']F'] = '@function.outer',
                            [']C'] = '@class.outer'
                        },
                        goto_previous_start = {
                            ['[f'] = '@function.outer',
                            ['[c'] = '@class.outer'
                        },
                        goto_previous_end = {
                            ['[F'] = '@function.outer',
                            ['[C'] = '@class.outer'
                        },
                    },
                },
            })
        end
    },

   {
        'folke/flash.nvim',
        config = function()
            require('flash').setup({})

            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            map('n', 's', '<cmd>lua require("flash").jump()<CR>', opts)
            map('x', 's', '<cmd>lua require("flash").jump()<CR>', opts)
            map('o', 's', '<cmd>lua require("flash").jump()<CR>', opts)

            map('n', 'S', '<cmd>lua require("flash").treesitter()<CR>', opts)
            map('x', 'S', '<cmd>lua require("flash").treesitter()<CR>', opts)
            map('o', 'S', '<cmd>lua require("flash").treesitter()<CR>', opts)

            map('o', 'r', '<cmd>lua require("flash").remote()<CR>', opts)
            map('o', 'R', '<cmd>lua require("flash").treesitter_search()<CR>', opts)
            map('x', 'R', '<cmd>lua require("flash").treesitter_search()<CR>', opts)
            map('c', '<c-s>', '<cmd>lua require("flash").toggle()<CR>', opts)
        end,
    },
    {
        'echasnovski/mini.surround',
        config = function()
            require('mini.surround').setup({
                mappings = {
                    add = 'gza',
                    delete = 'gzd',
                    find = 'gzf',
                    find_left = 'gzF',
                    highlight = 'gzh',
                    replace = 'gzr',
                    update_n_lines = 'gzn',
                },
            })
        end,
    },
    {
        'ggandor/flit.nvim',
        keys = function()
        local ret = {}
        for _, key in ipairs({ 'f', 'F', 't', 'T' }) do
            ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' }, desc = key }
        end
        return ret
        end,
        opts = { labeled_modes = 'nx' },
    },
    {
        'ggandor/leap.nvim',
        keys = {
        { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap Forward to' },
        { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap Backward to' },
        { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from Windows' },
        },
        config = function()
        local leap = require('leap')
        leap.add_default_mappings()
        vim.keymap.del({ 'x', 'o' }, 'x')
        vim.keymap.del({ 'x', 'o' }, 'X')
        end,
    },
    {   'tpope/vim-repeat', event = 'VimEnter' },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        -- event = 'BufRead',  -- You might want to load this on buffer read events
        opts = {
        enable_autocmd = false,
        },
    },
    {
        'echasnovski/mini.comment',
        -- event = 'VimEnter',
        opts = {
        options = {
            custom_commentstring = function()
            return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
            end,
        },
        },
    },

    {
        'echasnovski/mini.ai',
        -- event = 'VimEnter',  -- Changed from 'VeryLazy' to 'VimEnter'
        config = function()
            require('mini.ai').setup({
            n_lines = 500,
            custom_textobjects = {
                o = require('mini.ai').gen_spec.treesitter({
                a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                }),
                f = require('mini.ai').gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                c = require('mini.ai').gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                d = { "%f[%d]%d+" }, -- digits
                e = { -- Word with case
                {
                    "%u[%l%d]+%f[^%l%d]",
                    "%f[%S][%l%d]+%f[^%l%d]",
                    "%f[%P][%l%d]+%f[^%l%d]",
                    "^[%l%d]+%f[^%l%d]",
                },
                "^().*()$",
                },
                g = function() -- Whole buffer, similar to `gg` and 'G' motion
                return {
                    from = { line = 1, col = 1 },
                    to = {
                    line = vim.fn.line("$"),
                    col = vim.fn.getline("$"):len() > 0 and vim.fn.getline("$"):len() or 1,
                    }
                }
                end,
                u = require('mini.ai').gen_spec.function_call(), -- u for "Usage"
                U = require('mini.ai').gen_spec.function_call({ name_pattern = "[%w_]+" }), -- without dot in function name
            },
            })
        end,
    },

})
EOF

