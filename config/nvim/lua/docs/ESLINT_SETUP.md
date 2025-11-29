# 🔎 ESLint Setup (LazyVim + vtsls + Conform)

This setup uses the **Linting: ESLint** LazyExtra combined with vtsls and
PreeetierD.

The ESLint extra provides:

- ESLint LSP (diagnostics)
- ESLint code actions
- Missing import suggestions
- “Fix all fixable ESLint issues” support

We disable ESLint formatting so that Conform + PrettierD control formatting.

---

## ⚙️ Enable the ESLint Extra

Run:

````

:LazyExtras

```

Enable:

```

linting.eslint

```

That's it.

LazyVim automatically:

- Installs `eslint-lsp` through Mason
- Configures `eslint` LSP server
- Enables code actions

---

## 🛑 Disable ESLint Auto-Formatting

Add to:

```

config/nvim/lua/config/options.lua

````

```lua
vim.g.lazyvim_eslint_auto_format = false
````

This disables ESLint fixAll on save, but keeps:

* Diagnostics
* Code actions
* “Fix all fixable issues”
* Import suggestions
* All rules & warnings

---

## 🧱 What ESLint LSP Does (and does NOT do)

| Feature          | Enabled | Reason                      |
| ---------------- | ------- | --------------------------- |
| Diagnostics      | ✔       | Powered by ESLint LSP       |
| Code actions     | ✔       | Manual fixes                |
| Fix All (manual) | ✔       | From `<leader>ca`           |
| Fix All on save  | ❌       | Disabled (slow + redundant) |
| Formatting       | ❌       | Handled by prettierd        |

---

## 💡 Manual Fix All Hotkey

You can run:

```
<leader>ca
```

Then select:

```
✔ Fix all fixable ESLint issues
```

This is **fast** because ESLint_D is used in the background.

---

## 🧪 Testing

In a `.tsx` or `.ts` file, run:

```
:ConformInfo
```

You should see:

```
LSP: eslint, vtsls
prettierd (formatter)
```

ESLint is active for linting, not formatting.