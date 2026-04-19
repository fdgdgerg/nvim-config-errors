-- not used given we have nvim-tree file explorer, this setting does changes
-- the default explorer:
-- 3 (Tree): Displays files and directories in a hierarchical tree structure,
-- making it easier to navigate nested folders.
vim.cmd("let g:netrw_liststyle = 3")

-- sets the formating of text and comments
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function()
		vim.cmd([[ set fo=crqjaw ]])
	end,
})

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
-- This sets the number of spaces to use for each step of (auto)indent. When
-- you use commands like >> or << to shift lines, Vim will use 2 spaces per
-- indent level.
opt.shiftwidth = 2 -- 2 spaces for indent width
-- This converts tab characters to spaces. When you press the Tab key, Vim will
-- insert spaces instead of a tab character.
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
-- Disables line wrapping, meaning lines will not wrap automatically at the
-- edge of the screen. Instead, they will extend beyond the screen width.
opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = false -- highlight the current cursor line

-- appearance
-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- always show sign column to the left of numbers so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position otherwise backspacing would not work on the selected options.

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
