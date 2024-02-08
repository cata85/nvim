vim.g.mapleader = " "
vim.cmd("nnoremap <Space> <Nop>") -- Stops space from moving cursor. Annoying.
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
--require("/utils/statusline")
require("/utils/close_window")
require("vim-options")
