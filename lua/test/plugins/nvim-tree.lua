return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			local function expand()
				local node = api.tree.get_node_under_cursor()

				if node.nodes ~= nil and not node.open then
					-- expand or collapse folder
					api.node.open.edit()
				end
			end

			local function collapse()
				local node = api.tree.get_node_under_cursor()

				if node.nodes ~= nil then
					-- expand or collapse folder
					api.node.navigate.parent_close()
				else
					api.node.navigate.parent()
				end
			end

			-- open as vsplit on current node
			local function vsplit_preview_no_picker()
				local node = api.tree.get_node_under_cursor()

				if not (node.nodes ~= nil) then
					-- open file as vsplit
					api.node.open.vertical_no_picker()
				end

				-- Finally refocus on tree if it was lost
				api.tree.focus()
			end

			-- open as vsplit on current node
			local function hsplit_preview_no_picker()
				local node = api.tree.get_node_under_cursor()

				if not (node.nodes ~= nil) then
					-- expand or collapse folder
					-- open file as vsplit
					api.node.open.horizontal_no_picker()
				end

				-- Finally refocus on tree if it was lost
				api.tree.focus()
			end

			local function open_sacrifice()
				local node = api.tree.get_node_under_cursor()
				if not (node.nodes ~= nil) then
					api.node.open.edit()
				end
				api.tree.close()
			end

			local function open_instant_sacrifice()
				local node = api.tree.get_node_under_cursor()
				if not (node.nodes ~= nil) then
					api.node.open.no_window_picker()
				end
				api.tree.close()
			end

			local function open_instant_preview()
				local node = api.tree.get_node_under_cursor()
				if not (node.nodes ~= nil) then
					api.node.open.no_window_picker()
				end
				api.tree.focus()
			end

			local function vsplit_instant()
				local node = api.tree.get_node_under_cursor()
				if not (node.nodes ~= nil) then
					api.node.open.vertical_no_picker()
				end
			end

			local function split_instant()
				local node = api.tree.get_node_under_cursor()
				if not (node.nodes ~= nil) then
					api.node.open.horizontal_no_picker()
				end
			end

			local function open_instant()
				local node = api.tree.get_node_under_cursor()
				if not (node.nodes ~= nil) then
					api.node.open.no_window_picker()
				end
			end

			local function open()
				local node = api.tree.get_node_under_cursor()
				if not (node.nodes ~= nil) then
					api.node.open.edit()
				end
			end

			local function open_preview()
				local node = api.tree.get_node_under_cursor()
				if not (node.nodes ~= nil) then
					api.node.open.preview()
				end
			end

			-- default mappings
			-- api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "<leader>sV", vsplit_instant, opts("Open: Instant Vertical Split"))
			vim.keymap.set("n", "<leader>sv", vsplit_preview_no_picker, opts("Open: Instant Vertical Split Preview"))
			vim.keymap.set("n", "<leader>sH", split_instant, opts("Open: Instant Horizontal Split"))
			vim.keymap.set(
				"n",
				"<leader>sh",
				hsplit_preview_no_picker,
				opts("Open: Horizontal Split Preview No Picker")
			)
			vim.keymap.set("n", "<leader>sp", open_instant_preview, opts("Open: Instant Preview"))
			vim.keymap.set("n", "<leader>so", open_instant, opts("Open: Instant"))
			vim.keymap.set("n", "op", open_instant_sacrifice, opts("Open With Focus in Nvim-Tree"))
			vim.keymap.set("n", "oe", open_sacrifice, opts("Open"))
			vim.keymap.set("n", "oo", open_preview, opts("Open"))
			vim.keymap.set("n", "O", open, opts("Open: Sacrifice"))
			vim.keymap.set("n", "<leader>sm", api.tree.change_root_to_node, opts("Change Directory"))
			vim.keymap.set("n", "gd", api.node.show_info_popup, opts("Show Info"))
			vim.keymap.set("n", "<c-/>", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "l", expand, opts("Expand"))
			vim.keymap.set("n", "L", api.tree.expand_all, opts("Expand All"))
			vim.keymap.set("n", "h", collapse, opts("Collapse Directory"))
			vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
			vim.keymap.set("n", "rw", api.fs.rename_basename, opts("Rename: Basename"))
			vim.keymap.set("n", "rW", api.fs.rename, opts("Rename"))
			vim.keymap.set("n", "rr", api.fs.rename_full, opts("Rename: Full Path"))
			vim.keymap.set("n", "R", api.fs.rename_sub, opts("Rename: Omit Filename"))
			vim.keymap.set("n", "<C-r>", api.tree.reload, opts("Refresh"))
			vim.keymap.set("n", "-", api.node.run.cmd, opts("Run Command"))
			vim.keymap.set("n", "..", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "cd", api.tree.change_root_to_node, opts("cd"))
			vim.keymap.set("n", "a", api.fs.create, opts("Create File Or Directory"))
			vim.keymap.set("n", "bt", api.marks.bulk.trash, opts("Trash Bookmarks"))
			-- This deletes everything in the root if nothing is marked
			vim.keymap.set("n", "brm", api.marks.bulk.delete, opts("Delete Bookmarks"))
			vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarks"))
			vim.keymap.set("n", "<leader>ssb", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
			vim.keymap.set("n", "<leader>ssc", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
			vim.keymap.set("n", "<leader>sf", api.live_filter.start, opts("Live Filter: Start"))
			vim.keymap.set("n", "<leader>sF", api.live_filter.clear, opts("Live Filter: Clear"))
			vim.keymap.set("n", "<leader>ssh", api.tree.toggle_hidden_filter, opts("Live Filter: Clear"))
			vim.keymap.set("n", "<leader>ssi", api.tree.toggle_gitignore_filter, opts("Live Filter: Clear"))
			vim.keymap.set("n", "<leader>ssm", api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))
			vim.keymap.set("n", "<leader>ssg", api.node.open.toggle_group_empty, opts("Toggle Group Empty"))
			vim.keymap.set("n", "t", api.fs.trash, opts("Trash"))
			vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
			vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
			vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
			vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
			vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
			vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
			vim.keymap.set("n", "yw", api.fs.copy.basename, opts("Copy Basename"))
			vim.keymap.set("n", "yW", api.fs.copy.filename, opts("Copy Name"))
			vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
			vim.keymap.set("n", "yy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			vim.keymap.set("n", "ya", api.fs.copy.node, opts("Copy"))
			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
			vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
			vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
			vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
			vim.keymap.set("n", "q", api.tree.close, opts("Close"))
			vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
		end

		nvimtree.setup({
			on_attach = my_on_attach,
			diagnostics = {
				-- show diagnostics in sign column
				enable = true,
			},
			-- Keeps the cursor on the first letter of the filename when moving in
			-- the tree.
			hijack_cursor = true,
			-- for dressing.lua or a UI prompt decorator
			select_prompts = true,

			view = {
				-- size of view
				width = 35,
				relativenumber = true,
			},
			modified = {
				enable = true,
			},
			-- change folder arrow icons
			renderer = {
				-- Compact folders that only contain a single folder into one node. Boolean or function that
				-- takes one argument (the relative path of grouped folders) and returns a string to be
				-- displayed.
				group_empty = false,
				-- Show a small arrow before the folder node. Arrow will be a part of the
				-- node when using |renderer.indent_markers|.

				-- Display node whose name length is wider than the width of nvim-tree
				-- window in floating window.
				full_name = true,
				-- add indent markers to file structure
				indent_markers = {
					enable = true,
					icons = {
						corner = "│",
					},
				},
				highlight_modified = "all",
				highlight_git = "all",
				highlight_diagnostics = "all",
				highlight_opened_files = "all",
				highlight_bookmarks = "all",
			},
			-- disable window_picker for explorer to work well with window splits
			actions = {
				open_file = {
					window_picker = {
						enable = true,
						picker = "default",
						chars = "abcdefghijklmnopqrstuvwxyz0123456789",
						-- Table of buffer option names mapped to a list of option values that indicates to the
						-- picker that the buffer's window should not be selectable.
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
			tab = {
				sync = {
					close = true,
				},
			},
		})

		vim.cmd([[hi NvimTreeOpenedHL guisp=#1c98ea gui=underline]])
		vim.cmd([[hi NvimTreeBookmarkHL guibg=#2d0047]])
		vim.cmd([[hi CursorLine guibg=NONE]])

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		-- highlights the current buffer file in nvim-tree
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
