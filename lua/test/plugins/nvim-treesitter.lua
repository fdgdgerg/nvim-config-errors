return {
	{
		"nvim-treesitter/nvim-treesitter",
		enable = true,
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		lazy = false,
		config = function()
			-- vim.opt.runtimepath:prepend("/Users/joebu/.local/share/nvim/site")
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter")

			-- configure treesitter
			treesitter.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
				-- ensure these language parsers are installed
			})
			treesitter.install({
				"swift",
			})
		end,
		-- incremental selection
		-- start in visual mode (v)
		-- an  Selects [count]th parent node. If buffer has no treesitter parser, falls back to |vim.lsp.buf.selection_range()|.
		-- in  Selects [count]th previous (or first) child node. If buffer has no treesitter parser, falls back to |vim.lsp.buf.selection_range()|.
		-- ]n  Selects [count]th next node.
		-- [n  Selects [count]th previous node.
	},
}
