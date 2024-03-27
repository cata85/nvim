return {
    {
        -- <leader>gy copies link of current line to clipboard.
        'ruifm/gitlinker.nvim',
        config = function()
            require('gitlinker').setup()
        end,
    },
}
