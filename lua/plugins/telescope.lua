return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { {"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"} },
        lazy = false,
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>fd", builtin.find_files, {})
            vim.keymap.set("n", "<leader>ff", builtin.live_grep, {})
            vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<CR>", {})

            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("mapper")
            require("telescope").load_extension("noice")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            require("telescope").setup({
                extensions = {
                    ["file_browser"] = {
                        theme = "ivy",
                        hijack_netrw = true,
                    },
                },
            })

            vim.keymap.set(
                "n",
                "<leader>fp",
                ":Telescope file_browser path=%:p:h select_buffer=true<CR><Esc>",
                { noremap = true }
            )

            require("telescope").load_extension("file_browser")
        end,
    },
    {
        "debugloop/telescope-undo.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        lazy = false,
        keys = {
            {
                "<leader>u",
                "<cmd>Telescope undo<CR>",
                desc = "undo history",
            },
        },
        opts = {
            extensions = {
                undo = {
                    side_byside = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.6
                    },
                },
            },
        },
        config = function (_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
        end,
    },
}
