# 🟦 TypeScript Setup (LazyVim + vtsls)

This setup uses the `lang.typescript` LazyExtra, which installs:

- vtsls (TypeScript language server)
- TypeScript / TSX LSP configuration
- Mason support
- Debugging support (nvim-dap)

Compared to tsserver/typescript-language-server, **vtsls** provides:

- Faster startup
- Smarter auto-imports
- Better type narrowing
- Enhanced project-wide IntelliSense
- Improved JSX/TSX analysis

---

## ⚙️ Enable the TypeScript Extra

Run:

````

:LazyExtras

```

Enable:

```

lang.typescript

```

LazyVim will:

- Install `vtsls` via Mason
- Configure it as the TS/TSX LSP
- Disable tsserver and typescript-language-server automatically

---

## 🎯 How vtsls Works with ESLint and PrettierD

- vtsls → TypeScript IntelliSense, code actions, renaming, go-to-definition  
- ESLint → Rule-based diagnostics + fixes (“Fix all fixable issues”)  
- PrettierD → Formatting only  

vtsls does **not** format files because Conform is configured to handle that.

---

## 🧪 Testing

Run:

```

:LspInfo

```

You should see:

```

vtsls ACTIVE
eslint ACTIVE

```

Run:

```

:ConformInfo

```

You should see:

```

prettierd (formatter)
LSP: vtsls, eslint (not used for formatting)

```

---

## 🧹 Summary

| Purpose | Tool | Notes |
|--------|------|-------|
| IntelliSense | vtsls | Best TS LSP |
| Diagnostics | ESLint | Rules + warnings |
| Formatting | prettierd | Fastest, VSCode-matching |
| Fix Actions | ESLint | Manual only |