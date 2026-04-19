return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.90,
					height = 0.90,
				},
				path_display = { "smart" },
				mappings = {
					i = {
						["<M-k>"] = actions.move_selection_previous, -- move to prev result
						["<M-j>"] = actions.move_selection_next, -- move to next result
						["<C-u>"] = actions.results_scrolling_up,
						["<C-d>"] = actions.results_scrolling_down,
						["<M-Left>"] = actions.results_scrolling_left,
						["<M-Right>"] = actions.results_scrolling_right,
						["<C-c>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<leader>sh"] = actions.select_horizontal,
						["<leader>sv"] = actions.select_vertical,
						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-/>"] = actions.which_key,
						["<M-t>"] = actions.move_to_top,
						["<M-m>"] = actions.move_to_middle,
						["<M-b>"] = actions.move_to_bottom,
					},
					n = {
						["k"] = actions.move_selection_previous, -- move to prev result
						["j"] = actions.move_selection_next, -- move to next result
						["<M-k>"] = actions.move_selection_previous, -- move to prev result
						["<M-j>"] = actions.move_selection_next, -- move to next result
						["<C-u>"] = actions.results_scrolling_up,
						["<C-d>"] = actions.results_scrolling_down,
						["<M-Left>"] = actions.results_scrolling_left,
						["<M-Right>"] = actions.results_scrolling_right,
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
						["<CR>"] = actions.select_default,
						["O"] = actions.select_default,
						["<leader>sh"] = actions.select_horizontal,
						["<leader>sv"] = actions.select_vertical,
						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,
						["<C-/>"] = actions.which_key,
						["<M-t>"] = actions.move_to_top,
						["<M-m>"] = actions.move_to_middle,
						["<M-b>"] = actions.move_to_bottom,
					},
				},
			},
		})
		-- load fzf improve search preformance
		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local builtin = require("telescope.builtin")
		keymap.set("n", "<leader>fd", function()
			require("telescope.builtin").find_files({
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--no-ignore" },
			})
		end, { desc = "Fuzzy find files in cwd no ignore" })
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Lists items in the quickfix list" })
		keymap.set("n", "<leader>fb", function()
			builtin.buffers({
				sort_mru = true,
				ignore_current_buffer = true,
			})
		end, { desc = "Lists open buffers" })
		keymap.set(
			"n",
			"<leader>fp",
			"<cmd>Telescope registers<cr>",
			{ desc = "Lists vim registers, pastes the contents of the register on <cr>" }
		)
		keymap.set("n", "<leader>fg", "<cmd>Telescope git_commits<cr>", {
			desc = "Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h",
		})
	end,
}
