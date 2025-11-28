import tailwindcss from "@tailwindcss/vite";
import { devtools } from "@tanstack/devtools-vite";
import { tanstackRouter } from "@tanstack/router-plugin/vite";
import viteReact from "@vitejs/plugin-react";
import { exec } from "node:child_process";
import fs from "node:fs";
import path, { resolve } from "node:path";
import { defineConfig } from "vite";
import tsConfigPaths from "vite-tsconfig-paths";

async function getOrStartNvim() {
  let socket;

  // Try to read socket from file
  try {
    socket = fs.readFileSync("/tmp/nvim-singleton-socket", "utf8").trim();
  } catch { }

  // If socket exists AND is valid → return it
  if (socket && fs.existsSync(socket)) {
    return socket;
  }

  // No socket: start Neovim in iTerm2 in the background
  exec(`
    osascript <<EOF
    tell application "iTerm"
      activate
      create window with default profile
      tell current session of current window
        write text "nvim"
      end tell
    end tell
EOF`);

  // Poll for the new socket (Neovim will write the file)
  return await new Promise((resolve) => {
    const interval = setInterval(() => {
      try {
        const newSocket = fs.readFileSync("/tmp/nvim-singleton-socket", "utf8").trim();
        if (newSocket && fs.existsSync(newSocket)) {
          clearInterval(interval);
          resolve(newSocket);
        }
      } catch { }
    }, 150);
  });
}

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    // https://tanstack.com/devtools/latest/docs/vite-plugin
    devtools({
      enhancedLogs: {
        enabled: true,
      },
      injectSource: {
        enabled: true,
      },
      // new : nvim > vscode > zed
      editor: {
        name: "Auto (Neovim / VSCode / Zed)",

        open: async (filePath, lineNumber, columnNumber) => {
          const { promisify } = await import("node:util");
          const execAsync = promisify(exec);
          const file = path.normalize(filePath);
          const line = lineNumber ?? 1;
          const col = columnNumber ?? 1;

          const location = `${file}:${line}:${col}`;

          // 1) If Neovim singleton exists → use it
          let socket;
          try {
            socket = fs.readFileSync("/tmp/nvim-singleton-socket", "utf8").trim();
          } catch { }

          if (socket && fs.existsSync(socket)) {
            // Bring iTerm to front (like how VSCode comes to front)
            exec(`osascript -e 'tell application "iTerm" to activate'`);

            exec(
              `nvim --server ${socket} --remote-send ":e ${file}<CR>:call cursor(${line},${col})<CR>"`,
            );
            return;
          }

          // 2) Detect VSCode running
          let vscodeRunning = false;
          try {
            const out = await execAsync("pgrep -f 'Visual Studio Code' || true");
            vscodeRunning = !!out.stdout.trim();
          } catch { }

          if (vscodeRunning) {
            exec(`code -g "${location}"`);
            return;
          }

          // 3) Detect Zed running
          let zedRunning = false;
          try {
            const out = await execAsync("pgrep -f Zed || true");
            zedRunning = !!out.stdout.trim();
          } catch { }

          if (zedRunning) {
            exec(`zed --goto "${location}" || zed "${location}"`);
            return;
          }

          // 4) No editor is running → spawn Neovim and wait for socket
          const newSocket = await getOrStartNvim();
          exec(
            `nvim --server ${newSocket} --remote-send ":e ${file}<CR>:call cursor(${line},${col})<CR>"`,
          );
        },
      },
    }),
    tsConfigPaths({
      projects: ["./tsconfig.json"],
    }),
    tanstackRouter({ target: "react", autoCodeSplitting: true }),
    viteReact({
      // https://react.dev/learn/react-compiler
      babel: {
        plugins: [
          [
            "babel-plugin-react-compiler",
            {
              target: "19",
            },
          ],
        ],
      },
    }),
    tailwindcss(),
  ],
  resolve: {
    alias: {
      "@": resolve(__dirname, "./src"),
    },
  },
  // Custom rules for dev server:
  // For local development we set the api target to port:8080 instead of default port:3000
  server: {
    proxy: {
      "^/api/.*": {
        target: "http://localhost:8080",
        // changeOrigin: true, // only needed to fix CORS issues when backend does not allow requests from localhost:3000
      },
    },
  },
});

