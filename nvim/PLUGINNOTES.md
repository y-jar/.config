# Neovim Plugin Setup Guide

## File Structure
```
lua/plugin/
├── colorscheme.lua
├── telescope.lua
├── treesitter.lua
└── [your-plugin-name].lua
```

Each plugin gets its own `.lua` file in `lua/plugin/`.

---

## Basic Template

```lua
-- lua/plugin/PLUGIN-NAME.lua

return {
  {
    "github-username/repo-name",  -- REQUIRED: GitHub repository (find this in plugin docs)
    
    config = function()
      -- Code that runs AFTER the plugin is installed
      -- Usually you call the plugin's setup function here
      require("plugin-name").setup()
    end,
  },
}
```

**How to adapt:**
- Replace `github-username/repo-name` with the actual GitHub repo
- Replace `plugin-name` in the setup call (check plugin's README for the exact name)

---

## Full Template (All Options)

```lua
-- lua/plugin/PLUGIN-NAME.lua

return {
  {
    -- ===== REQUIRED =====
    "github-username/repo-name",  -- The GitHub repository
    
    -- ===== WHEN TO LOAD =====
    lazy = false,  -- false = load immediately when Neovim starts
                   -- true = only load when triggered (see below)
    
    priority = 1000,  -- Number: higher loads first (use 1000 for colorschemes)
                      -- Default plugins load at priority 50
                      -- Only matters if lazy = false
    
    -- ===== DEPENDENCIES =====
    dependencies = {
      "other-author/required-plugin",  -- Plugins this one needs to work
      "another-author/another-plugin",
    },
    
    -- ===== LOAD TRIGGERS (only if lazy = true) =====
    keys = {
      -- Load when these keys are pressed
      { "<leader>f", "<cmd>SomeCommand<cr>", desc = "Description" },
      -- <leader> = your leader key (space)
      -- <cmd>SomeCommand<cr> = the vim command to run
      -- desc = description (shows in which-key if you have it)
    },
    
    cmd = { "CommandName" },  -- Load when this vim command is run (like :CommandName)
    
    ft = { "lua", "python" },  -- Load when opening these file types
    
    event = "VeryLazy",  -- Load on specific events:
                         -- "VeryLazy" = after startup
                         -- "BufRead" = when opening a file
                         -- "InsertEnter" = when entering insert mode
    
    -- ===== SETUP CODE =====
    config = function()
      -- This function runs AFTER the plugin is loaded
      
      -- Most plugins need you to call their setup function:
      require("plugin-name").setup({
        -- Plugin options go here (check the plugin's docs)
        option1 = true,
        option2 = "value",
      })
      
      -- Some plugins need additional configuration:
      -- vim.cmd([[colorscheme theme-name]])  -- for colorschemes
      -- Custom keymaps, autocommands, etc.
    end,
    
    -- ===== ALTERNATIVE: init =====
    init = function()
      -- This runs BEFORE the plugin is loaded
      -- Use for settings that need to be set early
      vim.g.plugin_setting = true
    end,
  },
}
```

**How to adapt:**
- Most options are **optional** - start simple, add as needed
- Check the plugin's GitHub README for:
  - Required dependencies
  - Setup function name
  - Available options
  - Recommended keybindings

---

## Common Patterns

### Pattern 1: Simple Plugin (No Configuration)

Some plugins work out of the box with no setup.

```lua
-- lua/plugin/surround.lua

return {
  {
    "tpope/vim-surround",  -- Just install it, no config needed
  },
}
```

**When to use:** Plugin docs say "no setup required" or "works out of the box"

---

### Pattern 2: Plugin with Basic Setup

Most plugins need a simple setup call.

```lua
-- lua/plugin/comment.lua

return {
  {
    "numToStr/Comment.nvim",  -- The GitHub repo
    
    config = function()
      -- Call the setup function (name might be different per plugin)
      require("Comment").setup()
      -- Note: capital C in "Comment" - check docs for exact name
    end,
  },
}
```

**How to adapt:**
- Find the setup function name in the plugin's README (usually under "Setup" or "Configuration")
- It's usually `require("plugin-name").setup()`
- Case matters! Some use capitals, some don't

---

### Pattern 3: Plugin with Options

Many plugins let you customize behavior in the setup function.

```lua
-- lua/plugin/autopairs.lua

return {
  {
    "windwp/nvim-autopairs",
    
    config = function()
      require("nvim-autopairs").setup({
        -- These options go inside the setup({}) table
        check_ts = true,              -- Enable treesitter
        ts_config = {
          lua = { "string" },         -- Don't pair in lua strings
          javascript = { "template_string" },
        },
        disable_filetype = { "TelescopePrompt" },  -- Disable in telescope
      })
    end,
  },
}
```

**How to adapt:**
- Copy the setup structure from the plugin's README
- Options are plugin-specific - read the docs!
- Start with empty `setup()` then add options as needed

---

### Pattern 4: Lazy Load by Keymap

Only load the plugin when you press a specific key.

```lua
-- lua/plugin/telescope.lua

return {
  {
    "nvim-telescope/telescope.nvim",
    
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Telescope requires this
    },
    
    keys = {
      -- Plugin loads when you first press these keys
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find text" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    },
    
    config = function()
      require("telescope").setup({
        -- telescope options here
      })
    end,
  },
}
```

**How to adapt:**
- `<leader>ff` = space + f + f (assuming space is your leader)
- `<cmd>PluginCommand<cr>` = the command the plugin provides (check docs)
- This saves startup time - plugin only loads when you use it

---

### Pattern 5: Lazy Load by Command

Only load when you run a specific vim command.

```lua
-- lua/plugin/nvim-tree.lua

return {
  {
    "nvim-tree/nvim-tree.lua",
    
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },  -- Load when these commands run
    
    config = function()
      require("nvim-tree").setup()
    end,
  },
}
```

**How to adapt:**
- `cmd = { "Command1", "Command2" }` - commands that trigger loading
- Find available commands in plugin docs
- Good for plugins you don't use immediately

---

### Pattern 6: Lazy Load by File Type

Only load for specific file types.

```lua
-- lua/plugin/rust-tools.lua

return {
  {
    "simrat39/rust-tools.nvim",
    
    ft = { "rust" },  -- Only load when opening .rs files
    
    config = function()
      require("rust-tools").setup()
    end,
  },
}
```

**How to adapt:**
- `ft = { "python", "lua", "javascript" }` - file type names
- Perfect for language-specific plugins
- Keeps Neovim fast when editing other file types

---

### Pattern 7: Colorscheme

Colorschemes need special handling.

```lua
-- lua/plugin/colorscheme.lua

return {
  {
    "folke/tokyonight.nvim",
    
    lazy = false,     -- Load immediately (colorschemes can't be lazy)
    priority = 1000,  -- Load before other plugins
    
    config = function()
      -- Set the colorscheme options
      require("tokyonight").setup({
        style = "storm",        -- storm, moon, night, day
        transparent = false,
      })
      
      -- Apply the colorscheme
      vim.cmd([[colorscheme tokyonight]])
      -- Note: double square brackets for vim commands
    end,
  },
}
```

**How to adapt:**
- Always use `lazy = false` and `priority = 1000` for colorschemes
- The colorscheme name in `vim.cmd` might differ from the plugin name
- Check the plugin's README for the exact colorscheme command

---

### Pattern 8: Multiple Plugins in One File

You can group related plugins together.

```lua
-- lua/plugin/git.lua

return {
  -- Plugin 1
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  
  -- Plugin 2
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame" },
  },
  
  -- Plugin 3
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
  },
}
```

**When to use:** Group plugins by category (git, LSP, UI, etc.)

---

## Finding Information for Each Plugin

When you want to add a new plugin, look for these in its GitHub README:

1. **Repository name** → goes in `"author/repo"`
2. **Dependencies** → goes in `dependencies = {}`
3. **Setup function** → usually `require("name").setup()`
4. **Commands** → goes in `cmd = {}`
5. **Keybindings** → goes in `keys = {}`
6. **Options** → goes inside `setup({})`

---

## Quick Checklist

When adding a plugin:

- [ ] Create `lua/plugin/plugin-name.lua`
- [ ] Add the GitHub repo: `"author/repo"`
- [ ] Add dependencies if needed
- [ ] Add the `config` function with `setup()`
- [ ] Save and restart Neovim
- [ ] Run `:Lazy` to see if it installed
- [ ] Test that it works
- [ ] Add options/keybindings as needed

---

## Common Mistakes

❌ **Wrong:**
```lua
return {
  "author/plugin",  -- Missing outer table braces
}
```

✅ **Correct:**
```lua
return {
  {  -- Need double braces
    "author/plugin",
  },
}
```

---

❌ **Wrong:**
```lua
require(plugin-name).setup()  -- No quotes around name
```

✅ **Correct:**
```lua
require("plugin-name").setup()  -- Quotes needed
```

---

❌ **Wrong:**
```lua
config = function()
  setup()  -- Missing require
end
```

✅ **Correct:**
```lua
config = function()
  require("plugin-name").setup()  -- Need require
end
```

---

## Example: Adding a New Plugin Step-by-Step

**Goal:** Add `nvim-autopairs` plugin

**Step 1:** Find the GitHub repo
- Search "nvim-autopairs github"
- Find: `windwp/nvim-autopairs`

**Step 2:** Check the README for setup
- Says: `require("nvim-autopairs").setup()`

**Step 3:** Create the file
```lua
-- lua/plugin/autopairs.lua

return {
  {
    "windwp/nvim-autopairs",
    
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
}
```

**Step 4:** Save and restart Neovim

**Step 5:** Test it
- Type `(` and it should auto-close with `)`

**Done!**

---

## Useful Commands

After adding plugins, you can use these in Neovim:

- `:Lazy` - Open the Lazy plugin manager UI
- `:Lazy install` - Install new plugins
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy sync` - Install + update + clean

---

## Tips

1. **Start simple** - Get the plugin loading first, add options later
2. **Read the README** - Every plugin is different
3. **Use lazy loading** - Makes Neovim start faster
4. **One file per plugin** - Easier to manage (unless grouping related plugins)
5. **Comment your config** - Future you will thank you
6. **Test after adding** - Make sure it works before adding more

---

## Next Steps

1. Add a colorscheme (always first)
2. Add essential plugins (telescope, treesitter)
3. Add language-specific plugins as needed
4. Customize options over time
5. Share your config on GitHub!