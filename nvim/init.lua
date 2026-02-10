-- This is the start of my nvim config

-- leader set (this is for which-key to work when mappings.lua is called)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =====================================
-- Package manager (lazy vim)
-- =====================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
-- The above will check to see if Lazy is present.
-- If it isn't, it'll clone it from Github.

-- =====================================
-- plugin section (within plugin/)
-- =====================================
require("lazy").setup("plugin", opts) -- this loads all plugins within plugin/

-- =====================================
-- Reqs (seprate files within lua/)
-- =====================================
require("core.mappings")-- for mappings like theme switching and enabling and disabling options and entering menus
require("core.options")-- nvim or base plugin options that would go here
require("core.autocmd")--auto cmd stuff (no clue)
