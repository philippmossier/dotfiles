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

## nvim surround

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
