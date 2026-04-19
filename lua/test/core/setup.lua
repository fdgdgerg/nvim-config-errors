-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.autoread = true

-- refresh files if changed outside
vim.fn.timer_start(2000, function()
	vim.cmd("silent! checktime")
end, { ["repeat"] = -1 })
