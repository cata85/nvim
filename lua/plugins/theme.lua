return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        name = "kanagawa",
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                transparent = true,
                terminalColors = true,
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = "NONE", bg = "NONE" },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = "NONE", fg = "NONE" },
                        MasonNormal = { bg = "NONE", fg = "NONE" },

                        TelescopeTitle = { fg = "NONE", bold = true },
                        TelescopePromptNormal = { bg = "NONE" },
                        TelescopePromptBorder = { fg = theme.ui.fg_dim, bg = "NONE" },
                        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "NONE" },
                        TelescopeResultsBorder = { fg = theme.ui.fg_dim, bg = "NONE" },
                        TelescopePreviewNormal = { bg = "NONE" },
                        TelescopePreviewBorder = { bg = "NONE", fg = theme.ui.fg_dim, },

                        Pmenu = { fg = theme.ui.shade0, bg = "NONE" },  -- add `blend = vim.o.pumblend` to enable transparency
                        PmenuSel = { fg = "NONE", bg = "NONE" },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                    }
                end,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                }
            })

            vim.cmd.colorscheme("kanagawa-wave")
            --vim.cmd.colorscheme "kanagawa-dragon"
            -- vim.cmd.colorscheme "kanagawa-lotus"
        end,
    },
}
