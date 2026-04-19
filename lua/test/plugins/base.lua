return {
	"neovim/nvim-lspconfig",
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			treesitter.install({
				"templ",
			})
		end,
	},
}
