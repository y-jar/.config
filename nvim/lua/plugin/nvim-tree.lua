-- lua/plugin/nvim-tree.lua

-- These globals must be set BEFORE the plugin loads to properly disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false, -- Recommended for file explorers so they are ready immediately
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            -- Optionally enable 24-bit colour
            vim.opt.termguicolors = true

            -- Call the actual setup
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end,
    },
}