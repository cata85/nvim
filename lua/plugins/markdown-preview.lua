return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            local Mapper = require("./utils/mapper")
            vim.g.mkdp_auto_start = 1
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_browser = "/Applications/Google Chrome.app"
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                disable_sync_scroll = 0,
                sync_scroll_type = "middle",
                hide_yaml_meta = 1,
                sequence_diagrams = {},
                flowchart_diagrams = {},
            }
            vim.g.mkdp_filetypes = { "markdown", }
            vim.g.mkdp_theme = "dark"
            Mapper.map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { noremap = true, silent = true }, "Markdown", "Toggle Markdown Preview", "Toggle Markdown Preview")
        end,
    },
}
