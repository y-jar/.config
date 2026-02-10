return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},



        -- ==========================================
        -- CONFIG FUNCTION
        -- ==========================================
        config = function()
            -- start of config
            require('render-markdown').setup({
                completions = { lsp = { enabled = true } },

                -- This houses all the important information on what makes the .md work visually, here we can configure it wahooooo

                -- Link managment
                link = {
                    -- Turn on / off inline link icon rendering.
                    enabled = true,
                    -- Additional modes to render links.
                    render_modes = false,
                    -- How to handle footnote links, start with a '^'.
                    footnote = {
                        -- Turn on / off footnote rendering.
                        enabled = true,
                        -- Replace value with superscript equivalent.
                        superscript = true,
                        -- Added before link content.
                        prefix = '',
                        -- Added after link content.
                        suffix = '',
                    },
                    -- Inlined with 'image' elements.
                    image = '󰥶 ',
                    -- Inlined with 'email_autolink' elements.
                    email = '󰀓 ',
                    -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
                    hyperlink = '󰌹 ',
                    -- Applies to the inlined icon as a fallback.
                    highlight = 'RenderMarkdownLink',
                    -- Applies to WikiLink elements.
                    wiki = {
                        icon = '󱗖 ',
                        body = function()
                            return nil
                        end,
                        highlight = 'RenderMarkdownWikiLink',
                    },
                    -- Define custom destination patterns so icons can quickly inform you of what a link
                    -- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
                    -- patterns match a link the one with the longer pattern is used.
                    -- The key is for healthcheck and to allow users to change its values, value type below.
                    -- | pattern   | matched against the destination text                            |
                    -- | icon      | gets inlined before the link text                               |
                    -- | kind      | optional determines how pattern is checked                      |
                    -- |           | pattern | @see :h lua-patterns, is the default if not set       |
                    -- |           | suffix  | @see :h vim.endswith()                                |
                    -- | priority  | optional used when multiple match, uses pattern length if empty |
                    -- | highlight | optional highlight for 'icon', uses fallback highlight if empty |
                    custom = {
                        web = { pattern = '^http', icon = '󰖟 ' },
                        github = { pattern = 'github%.com', icon = '󰊤 ' },
                        gitlab = { pattern = 'gitlab%.com', icon = '󰮠 ' },
                        stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
                        wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 ' },
                        youtube = { pattern = 'youtube%.com', icon = '󰗃 ' },
                    },
                }, -- end of link

                -- Callout management
                callout = {
                    -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'.
                    -- The key is for healthcheck and to allow users to change its values, value type below.
                    -- | raw        | matched against the raw text of a 'shortcut_link', case insensitive |
                    -- | rendered   | replaces the 'raw' value when rendering                             |
                    -- | highlight  | highlight for the 'rendered' text and quote markers                 |
                    -- | quote_icon | optional override for quote.icon value for individual callout       |
                    -- | category   | optional metadata useful for filtering                              |

                    note      = { raw = '[!NOTE]',      rendered = '󰋽 Note',      highlight = 'RenderMarkdownInfo'},
                    tip       = { raw = '[!TIP]',       rendered = '󰌶 Tip',       highlight = 'RenderMarkdownSuccess'},
                    important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint'},
                    warning   = { raw = '[!WARNING]',   rendered = '󰀪 Warning',   highlight = 'RenderMarkdownWarn'},
                    caution   = { raw = '[!CAUTION]',   rendered = '󰳦 Caution',   highlight = 'RenderMarkdownError'},
                    abstract  = { raw = '[!ABSTRACT]',  rendered = '󰨸 Abstract',  highlight = 'RenderMarkdownInfo'},
                    summary   = { raw = '[!SUMMARY]',   rendered = '󰨸 Summary',   highlight = 'RenderMarkdownInfo'},
                    tldr      = { raw = '[!TLDR]',      rendered = '󰨸 Tldr',      highlight = 'RenderMarkdownInfo'},
                    info      = { raw = '[!INFO]',      rendered = '󰋽 Info',      highlight = 'RenderMarkdownInfo'},
                    todo      = { raw = '[!TODO]',      rendered = '󰗡 Todo',      highlight = 'RenderMarkdownInfo'},
                    hint      = { raw = '[!HINT]',      rendered = '󰌶 Hint',      highlight = 'RenderMarkdownSuccess'},
                    success   = { raw = '[!SUCCESS]',   rendered = '󰄬 Success',   highlight = 'RenderMarkdownSuccess'},
                    check     = { raw = '[!CHECK]',     rendered = '󰄬 Check',     highlight = 'RenderMarkdownSuccess'},
                    done      = { raw = '[!DONE]',      rendered = '󰄬 Done',      highlight = 'RenderMarkdownSuccess'},
                    question  = { raw = '[!QUESTION]',  rendered = '󰘥 Question',  highlight = 'RenderMarkdownWarn'},
                    help      = { raw = '[!HELP]',      rendered = '󰘥 Help',      highlight = 'RenderMarkdownWarn'},
                    faq       = { raw = '[!FAQ]',       rendered = '󰘥 Faq',       highlight = 'RenderMarkdownWarn'},
                    attention = { raw = '[!ATTENTION]', rendered = '󰀪 Attention', highlight = 'RenderMarkdownWarn'},
                    failure   = { raw = '[!FAILURE]',   rendered = '󰅖 Failure',   highlight = 'RenderMarkdownError'},
                    fail      = { raw = '[!FAIL]',      rendered = '󰅖 Fail',      highlight = 'RenderMarkdownError'},
                    missing   = { raw = '[!MISSING]',   rendered = '󰅖 Missing',   highlight = 'RenderMarkdownError'},
                    danger    = { raw = '[!DANGER]',    rendered = '󱐌 Danger',    highlight = 'RenderMarkdownError'},
                    error     = { raw = '[!ERROR]',     rendered = '󱐌 Error',     highlight = 'RenderMarkdownError'},
                    bug       = { raw = '[!BUG]',       rendered = '󰨰 Bug',       highlight = 'RenderMarkdownError'},
                    example   = { raw = '[!EXAMPLE]',   rendered = '󰉹 Example',   highlight = 'RenderMarkdownHint' },
                    quote     = { raw = '[!QUOTE]',     rendered = '󱆨 Quote',     highlight = 'RenderMarkdownQuote'},
                    cite      = { raw = '[!CITE]',      rendered = '󱆨 Cite',      highlight = 'RenderMarkdownQuote'},
                }, -- end of callout

                -- checkbox management
                checkbox = {
                    enabled = true,
                    render_modes = false,
                    bullet = false,
                    right_pad = 1,
                    unchecked = {
                        icon = '󰄱 ',
                        highlight = 'RenderMarkdownUnchecked',
                        scope_highlight = nil,
                    },
                    checked = {
                        icon = '󰱒 ',
                        highlight = 'RenderMarkdownChecked',
                        scope_highlight = nil,
                    },
                    custom = {
                        todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
                    },
                }, -- end of checkbox

                -- bullet management
                bullet = {
                    enabled = true,
                    render_modes = false,
                    icons = { '●', '○', '◆', '◇' },
                    ordered_icons = function(ctx)
                        local value = vim.trim(ctx.value)
                        local index = tonumber(value:sub(1, #value - 1))
                        return ('%d.'):format(index > 1 and index or ctx.index)
                    end,
                    left_pad = 0,
                    right_pad = 0,
                    highlight = 'RenderMarkdownBullet',
                    scope_highlight = {},
                },

                -- quote management
                quote = { icon = '▋' },
                anti_conceal = {
                    enabled = true,
                    -- Which elements to always show, ignoring anti conceal behavior. Values can either be
                    -- booleans to fix the behavior or string lists representing modes where anti conceal
                    -- behavior will be ignored. Valid values are:
                    --   head_icon, head_background, head_border, code_language, code_background, code_border,
                    --   dash, bullet, check_icon, check_scope, quote, table_border, callout, link, sign
                    ignore = {
                        code_background = true,
                        sign = true,
                    },
                    above = 0,
                    below = 0,
                }, -- end of quote management

                -- Table management
                pipe_table = {
                    -- Turn on / off pipe table rendering.
                    enabled = true,
                    -- Additional modes to render pipe tables.
                    render_modes = false,
                    -- Pre configured settings largely for setting table border easier.
                    -- | heavy  | use thicker border characters     |
                    -- | double | use double line border characters |
                    -- | round  | use round border corners          |
                    -- | none   | does nothing                      |
                    preset = 'none',
                    -- Determines how individual cells of a table are rendered.
                    -- | overlay | writes completely over the table, removing conceal behavior and highlights |
                    -- | raw     | replaces only the '|' characters in each row, leaving the cells unmodified |
                    -- | padded  | raw + cells are padded to maximum visual width for each column             |
                    -- | trimmed | padded except empty space is subtracted from visual width calculation      |
                    cell = 'padded',
                    -- Adjust the computed width of table cells using custom logic.
                    cell_offset = function()
                        return 0
                    end,
                    -- Amount of space to put between cell contents and border.
                    padding = 1,
                    -- Minimum column width to use for padded or trimmed cell.
                    min_width = 0,
                    -- Characters used to replace table border.
                    -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
                    -- stylua: ignore
                    border = {
                        '┌', '┬', '┐',
                        '├', '┼', '┤',
                        '└', '┴', '┘',
                        '│', '─',
                    },
                    -- Turn on / off top & bottom lines.
                    border_enabled = true,
                    -- Always use virtual lines for table borders instead of attempting to use empty lines.
                    -- Will be automatically enabled if indentation module is enabled.
                    border_virtual = false,
                    -- Gets placed in delimiter row for each column, position is based on alignment.
                    alignment_indicator = '━',
                    -- Highlight for table heading, delimiter, and the line above.
                    head = 'RenderMarkdownTableHead',
                    -- Highlight for everything else, main table rows and the line below.
                    row = 'RenderMarkdownTableRow',
                    -- Highlight for inline padding used to add back concealed space.
                    filler = 'RenderMarkdownTableFill',
                    -- Determines how the table as a whole is rendered.
                    -- | none   | { enabled = false }        |
                    -- | normal | { border_enabled = false } |
                    -- | full   | uses all default values    |
                    style = 'full',
                }, -- end of tabel management !!!!
            }) -- end of set up within config function
        end,
    },
}