return {
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        config = function ()
            require("gopher").setup({
                commands = {
                    go = "go",
                    gomodifytags = "gomodifytags",
                    gotests = "~/go/bin/gotests",
                    impl = "impl",
                    iferr = "iferr",
                },
            })
        end
    },
}
