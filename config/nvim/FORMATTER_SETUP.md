# 🧼 Neovim Formatting Setup (LazyVim + Conform + PrettierD)

This Neovim setup uses **Conform.nvim** with **PrettierD (prettierd)** as the
exclusive formatting engine for:

- JavaScript
- TypeScript
- JSX / TSX
- React / Next.js
- HTML / CSS / SCSS
- JSON / YAML
- Markdown
- Vue

ESLint is used **only for diagnostics & code actions**, never for formatting.

This results in:

- ⚡ Very fast formatting (20–40ms)
- 🎯 Output identical to VSCode Prettier
- 🚫 No ESLint fixAll slowdowns
- 🤖 vtsls language server for TypeScript IntelliSense
- ✔ Zero conflicts between tools

---

## 📦 Installed Tools

Make sure these are installed via `:Mason`:

```

prettierd
eslint-lsp
eslint_d
vtsls
tailwindcss-language-server
lua-language-server
shfmt
stylua

```

---

## ⚙️ PrettierD Formatting Configuration

Formatting is handled by this file:

```

config/nvim/lua/plugins/conform.lua

````

It:

- Assigns **prettierd** to all web-related filetypes
- Disables LSP formatting fallback for JS/TS so vtsls/eslint cannot format
- Allows LSP formatting for other languages (Go, Rust, Python, etc.)
- Integrates cleanly with LazyVim

You *must not* enable the LazyVim `formatting.prettier` extra, because it adds
slow `prettier` and conflicts with prettierd.

---

## 🛑 ESLint is NOT used for formatting

We disable ESLint auto-formatting with:

```lua
vim.g.lazyvim_eslint_auto_format = false
````

ESLint still provides:

* Diagnostics
* Code actions
* “Fix all fixable ESLint issues” (manual)

No fixAll on save. No LSP formatting. No conflicts.

---

## 🧪 Verify setup

Run:

```
:ConformInfo
```

You should see:

```
Formatters for this buffer:
prettierd
LSP: vtsls (not used)
```

If prettierd appears, setup is correct.

---

## 🧹 Summary

| Feature        | Tool       | Notes             |
| -------------- | ---------- | ----------------- |
| Formatting     | prettierd  | Fast + consistent |
| Diagnostics    | ESLint LSP | No formatting     |
| Fix actions    | ESLint     | Manual only       |
| TypeScript LSP | vtsls      | Modern + fast     |
| Save behavior  | Conform    | No fixAll on save |

This is the optimal JS/TS/React formatting setup for LazyVim.