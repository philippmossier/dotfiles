if true then return {} end

-- If your project is using eslint with eslint-plugin-prettier,
-- then this will automatically fix eslint errors and format with prettier on save.
-- Important: make sure not to add prettier to null-ls, otherwise this won't work!
-- https://www.lazyvim.org/configuration/recipes#add-eslint-and-use-it-for-formatting
return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = { eslint = {} },
			setup = {
				eslint = function()
					require("lazyvim.util").lsp.on_attach(function(client)
						if client.name == "eslint" then
							client.server_capabilities.documentFormattingProvider = true
						elseif client.name == "tsserver" then
							client.server_capabilities.documentFormattingProvider = false
						end
					end)
				end,
			},
		},
	}
}
