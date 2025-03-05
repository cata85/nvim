return {
    {
        "wet-sandwich/hyper.nvim",
        tag = "0.1.3",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("hyper").setup()
            local Mapper = require("./utils/mapper")
            Mapper.map(
                "n",
                "<leader>rr",
                require("hyper.view").show,
                { noremap = true },
                "Hyper",
                "Show Hyper",
                "Show Hyper"
            )
        end,
    },
}
