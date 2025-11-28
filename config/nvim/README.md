# 🧩 Neovim Setup (LazyVim + TypeScript + React + PrettierD + ESLint)

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

This Neovim configuration is built on **LazyVim v15+** and optimized for:

- TypeScript / JavaScript
- React / Next.js / TSX / JSX
- TailwindCSS
- ESLint diagnostics + code actions
- PrettierD formatting (fast)
- Modern LSP (vtsls)

Formatting is powered by **Conform + PrettierD**, while linting and fix actions
come from **ESLint LSP**. TypeScript intelligence is provided by **vtsls**.

This setup produces:

- ⚡ Fast formatting (20–40 ms)
- 🎯 Formatting identical to VSCode Prettier
- 🧠 Accurate TypeScript auto-imports + IntelliSense (vtsls)
- 🚫 No ESLint fixAll-on-save slowdowns
- 💬 Full diagnostics + fix actions from ESLint
- 🪁 TailwindCSS class support
- 🔍 Modern UI via Snacks + Blink

---

# 📦 Installed LazyExtras

Enabled via `:LazyExtras`:

```

linting.eslint
lang.tailwind
lang.typescript
coding.blink
coding.yanky
coding.mini-surround
editor.snacks_explorer
editor.snacks_picker
vscode

```

### ❗ Not enabled:

```

formatting.prettier  (we use prettierd instead)

```

---

# 📦 Required Tools (via :Mason)

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

Formatters & LSPs install automatically when enabling the required extras, except
for **prettierd**, which must be installed manually.

---

# 🧼 Formatting Architecture (PrettierD)

Formatting is handled exclusively by **Conform.nvim** using **prettierd**.

Config file:

```

config/nvim/lua/plugins/conform.lua

```

Highlights:

- prettierd is the ONLY formatter for JS/TS/React/CSS/JSON/etc.
- vtsls and ESLint formatting are disabled
- LSP formatting fallback is disabled for JS/TS
- LSP fallback stays enabled for other languages (Go, Rust, Python…)

To inspect formatters:

```

:ConformInfo

```

Expected:

```

Formatters for this buffer:
prettierd
LSP: vtsls (not used for formatting)

```

---

# 🔎 ESLint Architecture

ESLint is used only for **diagnostics and code actions**, not formatting.

Enabled via LazyExtra:

```

linting.eslint

````

Disable ESLint formatting:

```lua
vim.g.lazyvim_eslint_auto_format = false
````

This gives:

* ✔ ESLint diagnostics
* ✔ All ESLint code actions (including “Fix all fixable issues”)
* ❌ No ESLint formatting
* ❌ No ESLint fixAll-on-save

To run fix-all manually:

```
<leader>ca → Fix all fixable ESLint issues
```

---

# 🟦 TypeScript LSP Architecture (vtsls)

The TypeScript extra enables **vtsls**, which replaces tsserver.

Advantages:

* Faster project-wide analysis
* Better import suggestions
* More stable than tsserver
* Better handling of TSConfig project references

To inspect:

```
:LspInfo
```

Expected:

```
vtsls ACTIVE
eslint ACTIVE
```

---

# 🎨 TailwindCSS Support

Enabled via:

```
lang.tailwind
```

Automatically adds:

* TailwindCSS LSP
* Tailwind color inline highlighting
* Tailwind autocompletion

---

# 🔧 File Structure (Essential Files)

```
~/.config/nvim/
  lua/
    config/
      options.lua          ← disables eslint auto-format
    plugins/
      conform.lua          ← prettierd formatting setup
```

Optional docs:

```
docs/
  FORMATTER_SETUP.md
  ESLINT_SETUP.md
  TYPESCRIPT_SETUP.md
```

---

# ⌨️ Common Commands

| Purpose          | Command                                        |
| ---------------- | ---------------------------------------------- |
| Format file      | `<leader>cf` or `:w`                           |
| Show formatters  | `:ConformInfo`                                 |
| LSP info         | `:LspInfo`                                     |
| Mason UI         | `:Mason`                                       |
| Run ESLint fixes | `<leader>ca` → “Fix all fixable ESLint issues” |
| File picker      | `<leader><space>`                              |
| File explorer    | `<leader>e`                                    |

---

# 🧪 Verification Checklist

Run the following inside a `.tsx` or `.ts` file:

### 1️⃣ `:ConformInfo` should show:

```
prettierd
LSP: vtsls, eslint
```

### 2️⃣ `:LspInfo` should show:

```
vtsls
eslint
tailwindcss
```

### 3️⃣ `<leader>ca` should offer:

```
Fix all fixable ESLint issues
```

### 4️⃣ `:w` should format instantly using Prettier (via prettierd)

If all 4 work, the setup is perfect.

---

# 🎉 Summary

| Area              | Tool           | Notes                     |
| ----------------- | -------------- | ------------------------- |
| Formatting        | prettierd      | Fastest & VSCode-accurate |
| Diagnostics       | ESLint LSP     | Strict rule checking      |
| Code actions      | ESLint         | Manual fix-all            |
| TS IntelliSense   | vtsls          | Modern & fast             |
| Filetype fallback | Conform        | Disabled for JS/TS        |
| Editor experience | Snacks + Blink | Modern UI                 |

You now have a **top-tier TypeScript/React Neovim setup** with the best
formatting + linting architecture available today.