return {
    {
        "tpope/vim-fugitive",
        config = function()
            local Mapper = require("./utils/mapper")
            Mapper.map(
                "n",
                "<leader>gs",
                vim.cmd.Git,
                { noremap = true },
                "Vim-Fugitive",
                "Opens Git",
                "Opens tpope's Git"
            )
        end,
    },
}
