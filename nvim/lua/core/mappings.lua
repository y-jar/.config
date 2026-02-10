-- all keybinds go here :)
-- and other key-related things can go here too :)

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- requirement to mass map key groups for keybinds
local wk = require("which-key")

local function map(m, k, v)
	vim.keymap.set(m, k, v, { noremap = true, silent = true })
end
-- This creates a local function called map that makes it easier to set keybindings.
-- What it does:

-- m = mode (normal, insert, visual, etc.)
-- k = key (what you press)
-- v = value (what happens when you press it)

-- It calls vim.keymap.set() which is Neovim's built-in function for creating keybindings, and automatically adds:

-- noremap = true - prevents recursive mappings (important for safety)
-- silent = true - doesn't show the command in the command line

-- =====================================
-- MAPPINGS!
-- =====================================
-- NOTE: LEADER IS SET IN THE INIT.LUA FILE

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic Config & >>Keymaps
-- See :help vim.diagnostic.Opts
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- NVIM-TREE KEYBIND
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File [E]xplorer" })

-- =================================
-- VISUALS
-- =================================
-- twilight
wk.add({
	{ "<leader>v", group = "Visuals/UI", icon = { icon = "🎨", color = "cyan" } },
	{ "<leader>vh", "<cmd>ThemeHub<cr>", desc = "Theme [H]ub" },
	{ "<leader>vt", "<cmd>Twilight<cr>", desc = "Toggle [T]wilight" },
	{ "<leader>vn", "<cmd>set number!<cr>", desc = "Toggle Line [N]umbers" },
})

