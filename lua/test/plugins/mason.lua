return {
	{
		"mason-org/mason.nvim",
		opts = {},
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")
			local servers = { "gopls", "cmake", "templ" }

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = vim.lsp.config
			lspconfig("templ", {
				capabilities = capabilities,
			})
			vim.lsp.enable("templ")

			vim.lsp.config("tailwindcss", {
				capabilities = capabilities,
				filetypes = { "templ", "astro", "javascript", "typescript", "react" },
				init_options = { userLanguages = { templ = "html" } },
			})
			vim.lsp.enable("tailwindcss")
			vim.lsp.config("html", {
				capabilities = capabilities,
				filetypes = { "html", "templ" },
			})
			vim.lsp.enable("html")

			vim.lsp.config("htmx", {
				capabilities = capabilities,
				filetypes = { "html", "templ" },
			})
			vim.lsp.enable("htmx")

			mason.setup()
			mason_lspconfig.setup({
				ensure_installed = servers,
				automatic_installation = true,
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"prettierd", -- prettier formatter
					"stylua", -- lua formatter
					"isort", -- python formatter
					"black", -- python formatter
					"pylint", -- python linter
					"eslint_d", -- js linter
					"golangci-lint", -- go linter
					"goimports-reviser", -- go formatter
					"swiftformat", -- swift formatter
					"swiftlint", -- swift linter
				},
			})
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}),
			})

			-- for _, lsp in ipairs(servers) do
			-- 	lspconfig(lsp, capabilities = capabilities).setup({
			-- 		on_attach = on_attach,
			-- 		capabilities = capabilities,
			-- 	})
			-- end

			vim.filetype.add({ extension = { templ = "templ" } })
		end,
	},
}
