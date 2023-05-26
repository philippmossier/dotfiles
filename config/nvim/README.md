# tips for usage

## replace multicursor with native vim cmds

blogpost: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db

```
const a = 3;
const b = 3;
const c = 3;

to:

let a = 3;
let b = 3;
let c = 3;

with: /const <enter> <cgn> <esc> <..>
```

```
import HTML.Lazy as L

lazy2 lorem impsum
lazy3 lorem impsum
lazy4 lorem impsum

to:

import HTML.Lazy as L

L.lazy2 lorem impsum
L.lazy3 lorem impsum
L.lazy4 lorem impsum

with: /laz <enter> <C-v> <jj> <L.> <esc>
```

## leap.nvim

s leap forwarward example: sow (searches for word with letters ow)

S leap backwards

## mini surround:

```
# most important
add = "gza", -- Add surrounding in Normal and Visual modes (example gzaiw" or gza$")
delete = "gzd", -- Delete surrounding
replace = "gzr", -- Replace surrounding

# I duno what they do yet
find = "gzf", -- Find surrounding (to the right)
find_left = "gzF", -- Find surrounding (to the left)
highlight = "gzh", -- Highlight surrounding
update_n_lines = "gzn", -- Update `n_lines`

example1:

blogpost: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db

surround the link above with "https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db"

go to first letter h and then gza$"

example2: replace "" surroundings of the link with ``
gzr"`
```

gw = highlight word

## diagnostics

- current diagnostics setup in lsp.lua:

```
  opts = {
  diagnostics = {
  underline = true,
  update_in_insert = false,
  severity_sort = true,

  -- DISABLE inline diagnostics:
  -- you can show line diagnostics with <leader>cd (while hovering)
  -- or use <leader>xx to show a list of file diagnostics in a seperate window (you can close the window with <leader>xx aswell)
  virtual_text = false,
  ...
```

# lazyvim incl custom settings

## differences between wsl and mac:

### lspconfig for jdtls/java-lsp

Change some paths accordingly to your machine:

- `workspace_dir`: normaly nvim share folder like `/Users/phil/.local/share/nvim/jdtls_lsp_workspaces/`
- `"/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java",`
- `"/Users/phil/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"`
- `"/Users/phil/.local/share/nvim/mason/packages/jdtls/config_mac"`

### copilot

maybe you have to relogin into copilot via `:Copilot` and then select the action.

## n"vim surround

    Old text                    Command         New text

---

    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls

## mini.ai Default config

```lua
-- No need to copy this inside `setup()`. Will be used automatically.
{
  -- Table with textobject id as fields, textobject specification as values.
  -- Also use this to disable builtin textobjects. See |MiniAi.config|.
  custom_textobjects = nil,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Main textobject prefixes
    around = 'a',
    inside = 'i',

    -- Next/last variants
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',

    -- Move cursor to corresponding edge of `a` textobject
    goto_left = 'g[',
    goto_right = 'g]',
  },

  -- Number of lines within which textobject is searched
  n_lines = 50,

  -- How to search for object (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
  search_method = 'cover_or_next',

  -- Whether to disable showing non-error feedback
  silent = false,
}
```
