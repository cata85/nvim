return {
    "mvllow/modes.nvim",
    tag = "v0.2.0",
    config = function ()
        require("modes").setup({
            colors = {
                copy = "#fa0000",
                delete = "#c75c6a",
                insert = "#3d4c80",
                visual = "#f0fc00",
            },

            -- Set opacity for cursorline and number background
            line_opacity = 0.8,

            -- Enable cursor highlights
            set_cursor = true,

            -- Enable cursorline initially, and disable cursorline for inactive windows
            -- or ignored filetypes
            set_cursorline = true,

            -- Enable line number highlights to match cursorline
            set_number = true,

            -- Disable modes highlights in specified filetypes
            -- Please PR commonly ignored filetypes
            ignore_filetypes = { 'NvimTree', 'TelescopePrompt' },
        })
    end
}
