return {
  {
    "folke/lazy.nvim",
    lazy = false,
    init = function()
      if vim.g.vscode then
        return
      end

      local marker_file = "/tmp/nvim-singleton-socket"

      -- Read existing singleton socket (if any)
      local existing_socket = nil
      local f_read = io.open(marker_file, "r")
      if f_read then
        existing_socket = f_read:read("*l")
        f_read:close()
      end

      -- If a singleton socket exists and is valid → DO NOTHING
      if existing_socket and vim.loop.fs_stat(existing_socket) then
        return
      end

      -- Otherwise THIS instance becomes the singleton editor
      local socket = "/tmp/nvim-main-" .. tostring(vim.fn.getpid())
      vim.env.NVIM_SINGLETON_SOCKET = socket
      vim.fn.serverstart(socket)

      -- Write marker file ONLY IF it did not exist
      local f = io.open(marker_file, "w")
      if f then
        f:write(socket)
        f:close()
      end
    end,
  },
}
