-- this is my auto cmd file

-- close nvim-tree if it's last buffer open
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if #vim.api.nvim_list_bufs() == 1 and vim.bo.filetype == "NvimTree" then
			vim.cmd("quit")
		end
	end,
})

-- this makes the background auto transparent
-- This creates a 'tripwire' (autocommand) that listens for a specific event
vim.api.nvim_create_autocmd("ColorScheme", {
	-- pattern = "*" means "run this for EVERY theme I might switch to"
	pattern = "*",

	-- The callback is the actual logic that runs when the event is triggered
	callback = function()
		-- These are the "Highlight Groups." Neovim sees the UI as different layers.
		-- We are listing the specific layers we want to make transparent.
		local hl_groups = {
			"Normal", -- The main editor background
			"NormalNC", -- Background of windows that aren't focused
			"NormalFloat", -- Background of floating windows (like Which-Key or LSP popups)
			"FloatBorder", -- The border around those floating windows
			"SignColumn", -- The column on the left (where git signs/errors appear)
			"LineNr", -- The background of the line numbers
			"CursorLineNr", -- The background of the current line number
			"EndOfBuffer", -- The tildes (~) at the bottom of a file
			"MsgArea", -- The area at the very bottom where messages appear
		}

		-- This loop goes through our list and tells Neovim:
		-- "For this specific group, set the background (bg) to NONE."
		for _, group in ipairs(hl_groups) do
			-- 0 refers to the current buffer/global scope
			-- bg = "none" handles GUI/TrueColor terminals
			-- ctermbg = "none" handles older/standard terminal colors
			vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
		end
	end,
})
