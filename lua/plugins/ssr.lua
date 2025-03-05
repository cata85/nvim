return  {
    {
        "cshuaimin/ssr.nvim",
        config = function()
            require("ssr").setup({
                border = "rounded",
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                adjust_window = true,
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_confirm = "<cr>",
                    replace_all = "<leader><cr>",
                }
            })
            local Mapper = require("./utils/mapper")
            Mapper.map(
                {"n", "x"},
                "<leader>sr",
                function() require("ssr").open() end,
                {silent = true},
                "SSR",
                "Open SSR",
                "Open SSR"
            )
        end,
    },
}
