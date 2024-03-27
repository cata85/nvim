return {
    {
        "tpope/vim-fugitive",
        config = function()
            local Mapper = require("./utils/mapper")
            Mapper.map(
                "n",
                "<leader>vg",
                vim.cmd.Git,
                { noremap = true },
                "Vim-Fugitive",
                "Opens Git",
                "Opens tpope's Git"
            )
            Mapper.map(
                "n",
                "<leader>vs",
                ":Ghdiffsplit<CR>",
                { noremap = true },
                "Vim-Fugitive",
                "Git Diff Split",
                "Opens a split diff"
            )
            Mapper.map(
                "n",
                "<leader>vb",
                ":Git blame<CR>",
                { noremap = true },
                "Vim-Fugitive",
                "Git Blame",
                "Opens a blame window"
            )
        end,
    },
}
